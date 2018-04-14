import UseCases
import SwiftStructureInterface
import Foundation

class MethodGatheringVisitor: RecursiveElementVisitor {

    private(set) var methods = [UseCasesMethod]()
    private(set) var properties = [UseCasesProperty]()
    private(set) var type: UseCasesType = UseCasesTypeIdentifierBuilder(identifier: "").build()

    static func transformType(_ element: Element) -> UseCasesType {
        let visitor = MethodGatheringVisitor()
        element.accept(visitor)
        return visitor.type
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
        self.type = UseCasesOptionalType(type: type, isImplicitlyUnwrapped: iuo, useVerboseSyntax: false, implicitlyUnwrapped: iuo)
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
        let parameters = transformParameters(from: element)
        let returnType = element.returnType.map { MethodGatheringVisitor.transformType($0) } ?? UseCasesTypeIdentifier(identifier: "")
        return UseCasesMethod(name: element.name,
            genericParameters: [],
            returnType: UseCasesMethodType(originalType: returnType, resolvedType: returnType, erasedType: returnType),
            parametersList: parameters,
            declarationText: element.text,
            throws: element.throws)
    }

    private func transformGenericParameters(from element: FunctionDeclaration) -> [String] {
        return [] // TODO: support generic names
    }

    private func transformParameters(from element: FunctionDeclaration) -> [UseCasesParameter] {
        return element.parameters.map { parameter in
            UseCasesParameter(
                label: parameter.externalParameterName ?? "",
                name: parameter.localParameterName,
                type: UseCasesMethodType(originalType: MethodGatheringVisitor.transformType(parameter.type), resolvedType: MethodGatheringVisitor.transformType(parameter.type), erasedType: UseCasesTypeIdentifier(identifier: "z")),
                text: parameter.text,
                isEscaping: false)
        }
    }

    private func resolveType(_ type: Element?) -> (transformedType: String?, resolvedType: String?) {
        let visitor = TypeResolverVisitor(resolveUtil: ResolveUtil())
        type?.accept(visitor)
        return (visitor.transformedType, visitor.resolvedType)
    }

    override func visitVariableDeclaration(_ element: VariableDeclaration) {
        properties.append(UseCasesProperty(name: element.name,
            type: MethodGatheringVisitor.transformType(element.type),
            isWritable: element.isWritable,
            declarationText_: element.text))
    }
}
