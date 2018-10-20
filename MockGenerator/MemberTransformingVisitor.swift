import UseCases
import AST
import Resolver
import Foundation

class MemberTransformingVisitor: RecursiveElementVisitor {

    private(set) var initializers = [UseCasesInitializer]()
    private(set) var properties = [UseCasesProperty]()
    private(set) var methods = [UseCasesMethod]()
    private(set) var type: UseCasesType = UseCasesTypeIdentifierBuilder(identifier: "").build()
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    static func transformType(_ element: Element, resolver: Resolver) -> UseCasesType {
        let visitor = MemberTransformingVisitor(resolver: resolver)
        element.accept(visitor)
        return visitor.type
    }

    func transformType(_ element: Element) -> UseCasesType {
        return MemberTransformingVisitor.transformType(element, resolver: resolver)
    }

    override func visitType(_ element: Type) {
        type = UseCasesTypeIdentifier(identifier: element.text)
    }

    override func visitTypeIdentifier(_ element: TypeIdentifier) {
        if element.genericArgumentClause.arguments.isEmpty {
            let identifiers = transformToIdentifiers(element)
            type = UseCasesTypeIdentifier(identifiers: NSMutableArray(array: identifiers as NSArray))
        } else {
            type = UseCasesGenericType(identifier: element.typeName, arguments: element.genericArgumentClause.arguments.map { transformType($0) })
        }
    }

    override func visitArrayType(_ element: ArrayType) {
        type = UseCasesArrayType(type: transformType(element.elementType), useVerboseSyntax: false)
    }

    override func visitDictionaryType(_ element: DictionaryType) {
        let key = transformType(element.keyType)
        let value = transformType(element.valueType)
        type = UseCasesDictionaryType(keyType: key, valueType: value, useVerboseSyntax: false)
    }

    override func visitOptionalType(_ element: OptionalType) {
        let iuo = element.text.hasSuffix("!")
        let type = transformType(element.type)
        self.type = UseCasesOptionalType(type: type, isImplicitlyUnwrapped: iuo, useVerboseSyntax: false)
    }

    override func visitFunctionType(_ element: FunctionType) {
        type = UseCasesFunctionType(arguments: element.arguments.tupleTypeElementList.tupleTypeElements
            .compactMap { $0.typeAnnotation?.type ?? $0.type }
            .map { transformType($0) },
            returnType: transformType(element.returnType),
            throws: element.throws)
    }

    override func visitTupleType(_ element: TupleType) {
        let tupleElements = element.tupleTypeElementList.tupleTypeElements.compactMap(transformTupleType)
        type = UseCasesTupleType(tupleElements: tupleElements)
    }

    private func transformTupleType(_ e: TupleTypeElement) -> UseCasesTupleTypeTupleElement? {
        if let type = e.type ?? e.typeAnnotation?.type {
            return UseCasesTupleTypeTupleElement(label: e.label, type: transformType(type))
        }
        return nil
    }

    private func transformToIdentifiers(_ element: TypeIdentifier) -> [String] {
        var typeIdentifier: TypeIdentifier? = element
        var identifiers = [element.typeName]
        while let parent = typeIdentifier?.parentType {
            typeIdentifier = parent
            identifiers.append(parent.typeName)
        }
        return identifiers.reversed()
    }

    override func visitFunctionDeclaration(_ element: FunctionDeclaration) {
        guard isOverridable(element) else {
            return
        }
        methods.append(transform(element))
        super.visitFunctionDeclaration(element)
    }

    private func isOverridable(_ element: Declaration) -> Bool {
        return !element.hasPrivateModifier
               && !element.hasFilePrivateModifier
               && !element.isStatic
               && !element.hasClassDeclarationModifier
               && !element.isFinal
    }

    private func transform(_ element: FunctionDeclaration) -> UseCasesMethod {
        let genericParameter = transformGenericParameters(from: element)
        let parameters = transformParameters(element.parameterClause.parameters)
        let returnType = element.functionResult.map { transformType($0.type) } ?? UseCasesTypeIdentifier(identifier: "")
        return UseCasesMethod(name: element.name,
            genericParameters: genericParameter,
            returnType: UseCasesResolvedType(originalType: returnType, resolvedType: returnType),
            parametersList: parameters,
            declarationText: getDeclarationText(element),
            throws: element.throws,
            rethrows: element.rethrows
        )
    }

    private func getDeclarationText(_ element: Element) -> String {
        var text = ""
        for child in element.children where isAllowedInDeclarationText(child) {
            text.append(child.text)
        }
        return text.trimmingCharacters(in: .whitespaces)
    }

    private func isAllowedInDeclarationText(_ child: Element) -> Bool {
        return !(child is CodeBlock)
               && !(child is DeclarationModifier)
               && !(child is Attributes)
               && !(child is GetterSetterKeywordBlock)
               && !(child is Initializer)
    }

    private func transformGenericParameters(from element: FunctionDeclaration) -> [String] {
        return element.genericParameterClause?.parameters.map { param in
            param.name
        } ?? []
    }

    private func transformParameters(_ parameters: [Parameter]) -> [UseCasesParameter] {
        return parameters.map { parameter in
            UseCasesParameter(
                externalName: parameter.externalParameterName,
                internalName: parameter.localParameterName,
                type: UseCasesResolvedType(originalType: transformType(parameter.typeAnnotation.type), resolvedType: resolveAndTransform(parameter.typeAnnotation.type)),
                text: parameter.text,
                isEscaping: isEscaping(parameter))
        }
    }

    private func isEscaping(_ parameter: Parameter) -> Bool {
        return parameter.typeAnnotation.attributes.attributes.contains { $0.text == "@escaping" }
    }

    private func resolveAndTransform(_ type: Type) -> UseCasesType {
        let resolved = resolveType(type)
        return transformType(resolved)
    }

    private func resolveType(_ type: Type) -> Type {
        let visitor = TypeResolverVisitor(resolver: resolver)
        type.accept(visitor)
        return visitor.resolvedType ?? type
    }

    override func visitVariableDeclaration(_ element: VariableDeclaration) {
        guard isOverridable(element) && isPropertyOverridable(element),
              let name = element.name,
              let type = findType(element) else {
            return
        }
        let typeAnnotation = element.typeAnnotation == nil ? ": \(type.text)" : ""
        properties.append(UseCasesProperty(name: name,
            type: type,
            isWritable: isWritable(element),
            declarationText: "var \(getDeclarationText(element.patternInitializerList.patternInitializers[0]))\(typeAnnotation)"))
    }

    private func findType(_ element: VariableDeclaration) -> UseCasesType? {
        if let type = element.typeAnnotation?.type {
            return transformType(type)
        } else if let type = VariableTypeResolver.resolve(element, resolver: resolver) {
            return type
        }
        return nil
    }

    private func isWritable(_ element: VariableDeclaration) -> Bool {
        if element.isSetPrivate || element.isSetFilePrivate {
            return false
        } else if element.getterSetterKeywordBlock?.setterKeywordClause != nil {
            return true
        } else if element.getterSetterBlock?.setterClause != nil {
            return true
        }
        return (element.getterSetterKeywordBlock == nil
                && element.getterSetterBlock == nil
                && element.codeBlock == nil)
    }

    private func isPropertyOverridable(_ element: VariableDeclaration) -> Bool {
        return !element.isConstant
    }

    override func visitInitializerDeclaration(_ element: InitializerDeclaration) {
        guard isOverridable(element) else {
            return
        }
        initializers.append(UseCasesInitializer(
            parametersList: transformParameters(element.parameterClause.parameters),
            isFailable: element.isFailable,
            throws: element.throws))
    }
}
