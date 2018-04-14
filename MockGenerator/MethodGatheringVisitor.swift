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

    private func transform(_ method: FunctionDeclaration) -> UseCasesProtocolMethod {
        let resolvedReturnType = resolveType(method.returnType)
        return UseCasesProtocolMethod(
            name: method.name,
            returnType: resolvedReturnType.transformedType ?? method.returnType?.text,
            resolvedReturnType: resolvedReturnType.resolvedType.map { UseCasesType(typeName: $0) },
            parametersList: transformParameters(from: method),
            signature: method.text,
            throws: method.throws
        )
    }

    private func transformParameters(from method: FunctionDeclaration) -> [UseCasesParameter] {
        return method.parameters.map { p in
            let (transformedType, resolvedType) = resolveType(p.type)
            return UseCasesParameter(
                label: p.externalParameterName ?? p.localParameterName,
                name: p.localParameterName,
                type: transformedType ?? p.type.text,
                resolvedType: resolvedType.map { UseCasesType(typeName: $0) } ?? UseCasesType(typeName: p.type.text),
                text_: p.text)
        }
    }

    private func resolveType(_ type: Element?) -> (transformedType: String?, resolvedType: String?) {
        let visitor = TypeResolverVisitor(resolveUtil: ResolveUtil())
        type?.accept(visitor)
        return (visitor.transformedType, visitor.resolvedType)
    }

    override func visitVariableDeclaration(_ element: VariableDeclaration) {
        properties.append(UseCasesProperty(name: element.name,
            type: element.type.text,
            isWritable: element.isWritable,
            declarationText: element.text))
        super.visitVariableDeclaration(element)
    }
}
