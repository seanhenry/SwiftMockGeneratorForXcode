import UseCases
import SwiftStructureInterface

class MethodGatheringVisitor: RecursiveElementVisitor {

    private(set) var methods = [UseCasesProtocolMethod]()
    private(set) var properties = [UseCasesProtocolProperty]()

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
        properties.append(UseCasesProtocolProperty(name: element.name,
            type: element.type.text,
            isWritable: element.isWritable,
            signature: element.text))
        super.visitVariableDeclaration(element)
    }
}
