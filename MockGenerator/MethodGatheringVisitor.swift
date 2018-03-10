import UseCases
@testable import SwiftStructureInterface

class MethodGatheringVisitor: ElementVisitor {

    private(set) var methods = [UseCasesProtocolMethod]()
    private(set) var properties = [UseCasesProtocolProperty]()

    func visit(_ element: SwiftElement) {
    }

    func visit(_ element: SwiftTypeElement) {
    }

    func visit(_ element: SwiftFile) {
    }

    func visit(_ element: SwiftMethodElement) {
        methods.append(transform(element))
    }

    private func transform(_ method: SwiftMethodElement) -> UseCasesProtocolMethod {
        return UseCasesProtocolMethod(
            name: method.name,
            returnType: method.returnType?.text,
            resolvedReturnType: resolveType(method.returnType),
            parametersList: transformParameters(from: method),
            signature: method.text,
            throws: method.throws
        )
    }

    private func transformParameters(from method: SwiftMethodElement) -> [UseCasesParameter] {
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
        let resolved = ResolveUtil().resolveToElement(type)
        if let alias = resolved as? Typealias {
            result = UseCasesType(typeName: alias.typeName)
        } else if let genericType = resolved as? GenericParameterTypeDeclaration {
            result = UseCasesGenericType(typeName: genericType.text)
        }
        return result
    }

    func visit(_ element: SwiftPropertyElement) {
        var attribute = ""
        if let elementAttribute = element.attribute {
            attribute = elementAttribute + " "
        }
        properties.append(UseCasesProtocolProperty(name: element.name,
            type: element.type,
            isWritable: element.isWritable,
            signature: attribute + element.text))
    }
}
