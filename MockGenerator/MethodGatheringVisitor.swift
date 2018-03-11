import UseCases
@testable import SwiftStructureInterface

class MethodGatheringVisitor: RecursiveElementVisitor {

    private(set) var methods = [UseCasesProtocolMethod]()
    private(set) var properties = [UseCasesProtocolProperty]()

    override func visitFunctionDeclaration(_ element: FunctionDeclaration) {
        methods.append(transform(element))
        super.visitFunctionDeclaration(element)
    }

    private func transform(_ method: FunctionDeclaration) -> UseCasesProtocolMethod {
        return UseCasesProtocolMethod(
            name: method.name,
            returnType: method.returnType?.text,
            resolvedReturnType: resolveType(method.returnType),
            parametersList: transformParameters(from: method),
            signature: method.text,
            throws: method.throws
        )
    }

    private func transformParameters(from method: FunctionDeclaration) -> [UseCasesParameter] {
        return method.parameters.map { p in
            UseCasesParameter(
                label: p.externalParameterName ?? p.localParameterName,
                name: p.localParameterName,
                type: p.type.text,
                resolvedType: resolveType(p.type) ?? UseCasesType(typeName: p.type.text),
                text_: p.text)
        }
    }

    private func resolveType(_ type: Element?) -> UseCasesType? {
        guard let type = type else { return nil }
        var result: UseCasesType?
        let resolved = ResolveUtil().resolve(type)
        if let alias = resolved as? Typealias {
            result = resolveType(alias.typealiasAssignment.type) ?? UseCasesType(typeName: alias.typealiasAssignment.type.text)
        } else if resolved is GenericParameterClause {
            result = UseCasesGenericType(typeName: type.text)
        }
        return result
    }

    override func visitVariableDeclaration(_ element: VariableDeclaration) {
        properties.append(UseCasesProtocolProperty(name: element.name,
            type: element.type.text,
            isWritable: element.isWritable,
            signature: element.text))
        super.visitVariableDeclaration(element)
    }
}
