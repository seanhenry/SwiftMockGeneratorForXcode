import UseCases
import AST
import Resolver
import Foundation

class MemberTransformingVisitor: RecursiveElementVisitor {

    private(set) var initializers = [UseCasesInitializer]()
    private(set) var properties = [UseCasesProperty]()
    private(set) var methods = [UseCasesMethod]()
    private(set) var subscripts = [UseCasesSubscript]()
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
        if let genericArgumentClause = element.genericArgumentClause {
            type = UseCasesGenericType(identifier: element.typeName, arguments: genericArgumentClause.arguments.map { transformType($0) })
        } else {
            let identifiers = element.typeNames
            type = UseCasesTypeIdentifier(identifiers: NSMutableArray(array: identifiers as NSArray))
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
        type = UseCasesFunctionType(arguments: element.functionTypeArgumentClause.arguments
            .compactMap { $0.typeAnnotation?.type ?? $0.type }
            .map { transformType($0) },
            returnType: transformType(element.returnType),
            throws: element.throws)
    }

    override func visitParenthesizedType(_ element: ParenthesizedType) {
        let tupleType = UseCasesTupleTypeTupleElement(label: nil, type: transformType(element.type))
        type = UseCasesTupleType(tupleElements: [tupleType])
    }

    override func visitMetatypeType(_ element: MetatypeType) {
        type = UseCasesTypeIdentifier(identifiers: NSMutableArray(array: [element.type.text, element.metatype.text]))
    }

    override func visitTupleType(_ element: TupleType) {
        let tupleElements = element.tupleTypeElementList.tupleTypeElements.compactMap(transformTupleType)
        type = UseCasesTupleType(tupleElements: tupleElements)
    }

    private func transformTupleType(_ e: TupleTypeElement) -> UseCasesTupleTypeTupleElement? {
        if let type = e.type ?? e.typeAnnotation?.type {
            return UseCasesTupleTypeTupleElement(label: e.elementName?.text, type: transformType(type))
        }
        return nil
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
        let visitor = DeclarationTextVisitor()
        element.accept(visitor)
        return visitor.text.trimmingCharacters(in: .whitespaces)
    }

    private func transformGenericParameters(from element: FunctionDeclaration) -> [String] {
        return element.genericParameterClause?.parameters.map { param in
            param.name
        } ?? []
    }

    private func transformParameters(_ parameters: [Parameter]) -> [UseCasesParameter] {
        return parameters.map { parameter in
            var internalName = parameter.localParameterName
            if internalName == "`let`" {
                internalName = "let"
            } else if internalName == "`var`" {
                internalName = "var"
            }
            return UseCasesParameter(
                externalName: parameter.externalParameterName,
                internalName: internalName,
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

    private func isWritable(_ element: GetterSetterDeclaration) -> Bool {
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

    override func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
        guard isOverridable(element),
            let functionResult = element.functionResult else {
            return
        }
        let returnType = transformType(functionResult.type)
        let resolvedType = UseCasesResolvedType(originalType: returnType, resolvedType: returnType)
        subscripts.append(
            UseCasesSubscript(
                returnType: resolvedType,
                parameters: transformParameters(element.parameterClause.parameters),
                isWritable: isWritable(element),
                declarationText: getDeclarationText(element)
            )
        )
    }
}

extension ParameterClause {

    var parameters: [Parameter] {
        return parameterList?.parameters ?? []
    }
}


extension FunctionTypeArgumentClause {

    var arguments: [FunctionTypeArgument] {
        return functionTypeArgumentList?.arguments ?? []
    }

}

private class DeclarationTextVisitor: RecursiveElementVisitor {
    var text = ""

    override func visitLeafNode(_ element: LeafNode) {
        text += element.text
    }

    override func visitParameterClause(_ element: ParameterClause) {
        // attributes are allowed in here
        text += element.text
    }

    // These elements are ignored
    override func visitAttributes(_ element: Attributes) {}
    override func visitDeclarationModifier(_ element: DeclarationModifier) {}
    override func visitCodeBlock(_ element: CodeBlock) {}
    override func visitGetterSetterBlock(_ element: GetterSetterBlock) {}
    override func visitGetterSetterKeywordBlock(_ element: GetterSetterKeywordBlock) {}
    override func visitInitializer(_ element: Initializer) {}
}
