import UseCases
import AST
import SwiftyKit
import Foundation

class MemberTransformingVisitor: RecursiveElementVisitor {

    private(set) var initializers = [UseCases.Initializer]()
    private(set) var properties = [UseCases.Property]()
    private(set) var methods = [UseCases.Method]()
    private(set) var subscripts = [UseCases.Subscript]()
    private(set) var type: UseCases.`Type` = TypeIdentifier.Builder(identifier: "").build()
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    static func transformType(_ element: AST.Element, resolver: Resolver) -> UseCases.`Type` {
        let visitor = MemberTransformingVisitor(resolver: resolver)
        element.accept(visitor)
        return visitor.type
    }

    func transformType(_ element: AST.Element) -> UseCases.`Type` {
        return MemberTransformingVisitor.transformType(element, resolver: resolver)
    }

    override func visitType(_ element: AST.`Type`) {
        type = UseCases.TypeIdentifier(identifier: element.text)
    }

    override func visitTypeIdentifier(_ element: AST.TypeIdentifier) {
        if let genericArgumentClause = element.genericArgumentClause {
            type = GenericType(identifier: element.typeName, arguments: genericArgumentClause.arguments.map { transformType($0) })
        } else {
            let identifiers = element.typeNames
            type = UseCases.TypeIdentifier(identifiers: NSMutableArray(array: identifiers as NSArray))
        }
    }

    override func visitArrayType(_ element: AST.ArrayType) {
        type = UseCases.ArrayType(type: transformType(element.elementType), useVerboseSyntax: false)
    }

    override func visitDictionaryType(_ element: AST.DictionaryType) {
        let key = transformType(element.keyType)
        let value = transformType(element.valueType)
        type = UseCases.DictionaryType(keyType: key, valueType: value, useVerboseSyntax: false)
    }

    override func visitOptionalType(_ element: AST.OptionalType) {
        let iuo = element.text.hasSuffix("!")
        let type = transformType(element.type)
        self.type = UseCases.OptionalType(type: type, isImplicitlyUnwrapped: iuo, useVerboseSyntax: false)
    }

    override func visitFunctionType(_ element: AST.FunctionType) {
        type = UseCases.FunctionType(arguments: element.functionTypeArgumentClause.arguments
            .compactMap { $0.typeAnnotation?.type ?? $0.type }
            .map { transformType($0) },
            returnType: transformType(element.returnType),
            throws: element.throws)
    }

    override func visitParenthesizedType(_ element: ParenthesizedType) {
        let tupleType = UseCases.TupleType.TupleElement(label: nil, type: transformType(element.type))
        type = TupleType(tupleElements: [tupleType])
    }

    override func visitMetatypeType(_ element: MetatypeType) {
        type = UseCases.TypeIdentifier(identifiers: NSMutableArray(array: [element.type.text, element.metatype.text]))
    }

    override func visitTupleType(_ element: AST.TupleType) {
        let tupleElements = element.tupleTypeElementList.tupleTypeElements.compactMap(transformTupleType)
        type = TupleType(tupleElements: tupleElements)
    }

    private func transformTupleType(_ e: TupleTypeElement) -> UseCases.TupleType.TupleElement? {
        if let type = e.type ?? e.typeAnnotation?.type {
            return TupleType.TupleElement(label: e.elementName?.text, type: transformType(type))
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

    private func transform(_ element: FunctionDeclaration) -> UseCases.Method {
        let genericParameter = transformGenericParameters(from: element)
        let parameters = transformParameters(element.parameterClause.parameters)
        let returnType = element.functionResult.map { transformType($0.type) } ?? UseCases.TypeIdentifier(identifier: "")
        return UseCases.Method(name: element.name,
            genericParameters: genericParameter,
            returnType: UseCases.ResolvedType(originalType: returnType, resolvedType: returnType),
            parametersList: parameters,
            declarationText: getDeclarationText(element),
            throws: element.throws,
            rethrows: element.rethrows
        )
    }

    private func getDeclarationText(_ element: AST.Element) -> String {
        let visitor = DeclarationTextVisitor()
        element.accept(visitor)
        return visitor.text.trimmingCharacters(in: .whitespaces)
    }

    private func transformGenericParameters(from element: FunctionDeclaration) -> [String] {
        return element.genericParameterClause?.parameters.map { param in
            param.name
        } ?? []
    }

    private func transformParameters(_ parameters: [AST.Parameter]) -> [UseCases.Parameter] {
        return parameters.map { parameter in
            var internalName = parameter.localParameterName
            if internalName == "`let`" {
                internalName = "let"
            } else if internalName == "`var`" {
                internalName = "var"
            }
            return UseCases.Parameter(
                externalName: parameter.externalParameterName,
                internalName: internalName,
                type: UseCases.ResolvedType(originalType: transformType(parameter.typeAnnotation.type), resolvedType: resolveAndTransform(parameter.typeAnnotation.type)),
                text: parameter.text,
                isEscaping: isEscaping(parameter))
        }
    }

    private func isEscaping(_ parameter: AST.Parameter) -> Bool {
        return parameter.typeAnnotation.attributes.attributes.contains { $0.text == "@escaping" }
    }

    private func resolveAndTransform(_ type: AST.`Type`) -> UseCases.`Type` {
        let resolved = resolveType(type)
        return transformType(resolved)
    }

    private func resolveType(_ type: AST.`Type`) -> AST.`Type` {
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
        properties.append(UseCases.Property(name: name,
            type: type,
            isWritable: isWritable(element),
            declarationText: "var \(getDeclarationText(element.patternInitializerList.patternInitializers[0]))\(typeAnnotation)"))
    }

    private func findType(_ element: VariableDeclaration) -> UseCases.`Type`? {
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
        initializers.append(UseCases.Initializer(
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
        let resolvedType = UseCases.ResolvedType(originalType: returnType, resolvedType: returnType)
        subscripts.append(
            UseCases.Subscript(
                returnType: resolvedType,
                parameters: transformParameters(element.parameterClause.parameters),
                isWritable: isWritable(element),
                declarationText: getDeclarationText(element)
            )
        )
    }
}

extension ParameterClause {

    var parameters: [AST.Parameter] {
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
    override func visitInitializer(_ element: AST.Initializer) {}
}
