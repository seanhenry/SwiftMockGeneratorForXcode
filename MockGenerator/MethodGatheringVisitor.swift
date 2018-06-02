import UseCases
import SwiftStructureInterface
import Foundation

class MethodGatheringVisitor: RecursiveElementVisitor {

    private(set) var initializers = [UseCasesInitializer]()
    private(set) var properties = [UseCasesProperty]()
    private(set) var methods = [UseCasesMethod]()
    private(set) var type: UseCasesType = UseCasesTypeIdentifierBuilder(identifier: "").build()

    static func transformType(_ element: Element) -> UseCasesType {
        let visitor = MethodGatheringVisitor()
        element.accept(visitor)
        return visitor.type
    }

    override func visitType(_ element: Type) {
        type = UseCasesTypeIdentifier(identifier: element.text)
    }

    override func visitTypeIdentifier(_ element: TypeIdentifier) {
        if element.genericArguments.isEmpty {
            let identifiers = transformToIdentifiers(element)
            type = UseCasesTypeIdentifier(identifiers: NSMutableArray(array: identifiers as NSArray))
        } else {
            type = UseCasesGenericType(identifier: element.typeName, arguments: element.genericArguments.map { MethodGatheringVisitor.transformType($0) })
        }
    }

    override func visitArrayType(_ element: ArrayType) {
        type = UseCasesArrayType(type: MethodGatheringVisitor.transformType(element.elementType), useVerboseSyntax: false)
    }

    override func visitDictionaryType(_ element: DictionaryType) {
        let key = MethodGatheringVisitor.transformType(element.keyType)
        let value = MethodGatheringVisitor.transformType(element.valueType)
        type = UseCasesDictionaryType(keyType: key, valueType: value, useVerboseSyntax: false)
    }

    override func visitOptionalType(_ element: OptionalType) {
        let iuo = element.text.hasSuffix("!")
        let type = MethodGatheringVisitor.transformType(element.type)
        self.type = UseCasesOptionalType(type: type, isImplicitlyUnwrapped: iuo, useVerboseSyntax: false)
    }

    override func visitFunctionType(_ element: FunctionType) {
        type = UseCasesFunctionType(arguments: element.arguments.elements.map { MethodGatheringVisitor.transformType($0.typeAnnotation.type) },
            returnType: MethodGatheringVisitor.transformType(element.returnType),
            throws: element.throws)
    }

    override func visitTupleType(_ element: TupleType) {
        type = UseCasesTupleType(tupleElements: element.elements.map { UseCasesTupleTypeTupleElement(label: $0.label, type: MethodGatheringVisitor.transformType($0.typeAnnotation.type)) })
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
        methods.append(transform(element))
        super.visitFunctionDeclaration(element)
    }

    private func transform(_ element: FunctionDeclaration) -> UseCasesMethod {
        let genericParameter = transformGenericParameters(from: element)
        let parameters = transformParameters(element.parameters)
        let returnType = element.returnType.map { MethodGatheringVisitor.transformType($0) } ?? UseCasesTypeIdentifier(identifier: "")
        return UseCasesMethod(name: element.name,
            genericParameters: genericParameter,
            returnType: UseCasesResolvedType(originalType: returnType, resolvedType: returnType),
            parametersList: parameters,
            declarationText: element.text,
            throws: element.throws)
    }

    private func transformGenericParameters(from element: FunctionDeclaration) -> [String] {
        return element.genericParameterClause?.parameters.map { param in
            param.typeName
        } ?? []
    }

    private func transformParameters(_ parameters: [Parameter]) -> [UseCasesParameter] {
        return parameters.map { parameter in
            UseCasesParameter(
                externalName: parameter.externalParameterName,
                internalName: parameter.localParameterName,
                type: UseCasesResolvedType(originalType: MethodGatheringVisitor.transformType(parameter.typeAnnotation.type), resolvedType: resolveAndTransform(parameter.typeAnnotation.type)),
                text: parameter.text,
                isEscaping: isEscaping(parameter))
        }
    }

    private func isEscaping(_ parameter: Parameter) -> Bool {
        return parameter.typeAnnotation.attributes.contains("@escaping")
    }

    private func resolveAndTransform(_ type: Type) -> UseCasesType {
        let resolved = resolveType(type)
        return MethodGatheringVisitor.transformType(resolved)
    }

    private func resolveType(_ type: Type) -> Type {
        let visitor = TypeResolverVisitor(resolveUtil: ResolveUtil())
        type.accept(visitor)
        return visitor.resolvedType ?? type
    }

    override func visitVariableDeclaration(_ element: VariableDeclaration) {
        properties.append(UseCasesProperty(name: element.name,
            type: MethodGatheringVisitor.transformType(element.type),
            isWritable: element.isWritable,
            declarationText: element.text))
    }

    override func visitInitialiserDeclaration(_ element: InitialiserDeclaration) {
        initializers.append(UseCasesInitializer(
            parametersList: transformParameters(element.parameters),
            isFailable: element.isFailable,
            throws: element.throws))
    }
}
