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
            resolvedReturnType: resolveReturnType(method.returnType),
            parametersList: transformParameters(from: method),
            signature: method.text,
            throws: false
        )
    }

    private func resolveReturnType(_ type: Element?) -> UseCasesType? {
        guard let type = type else { return nil }
        let resolved = ResolveUtil().resolveToElement(type)
        if let generic = resolved as? GenericParameterTypeDeclaration {
            return UseCasesGenericType(typeName: generic.text)
        }
        return UseCasesType(typeName: type.text)
    }

    private func transformParameters(from method: SwiftMethodElement) -> [UseCasesParameter] {
        let parameters = parseParameters(from: method)
        let resolvedTypes = getResolvedParameterTypes(from: method)
        return transformParameters(parameters, resolvedTypes: resolvedTypes)
    }

    private func parseParameters(from method: SwiftMethodElement) -> [UseCasesParameter] {
        return UseCasesProtocolMethod( // Kotlin native doesn't give access to ParameterUtil
            name: "",
            returnType: nil,
            parameters: getParametersText(element:  method),
            signature: ""
        ).parametersList as! [UseCasesParameter]
    }

    private func getParametersText(element: SwiftMethodElement) -> String {
        return element.parameters.map { $0.text }.joined(separator: ", ")
    }

    private func getResolvedParameterTypes(from element: SwiftMethodElement) -> [UseCasesType?] {
        return element.parameters.map(transformToParameterType)
    }

    private func transformToParameterType(_ parameter: MethodParameter) -> UseCasesType? {
        var result: UseCasesType?
        let resolved = ResolveUtil().resolveToElement(parameter.type)
        if let alias = resolved as? Typealias {
            result = UseCasesType(typeName: alias.typeName)
        } else if let genericType = resolved as? GenericParameterTypeDeclaration {
            result = UseCasesGenericType(typeName: genericType.text)
        }
        return result
    }

    private func transformParameters(_ parameters: [UseCasesParameter], resolvedTypes: [UseCasesType?]) -> [UseCasesParameter] {
        let parametersAndTypes = zip(parameters, resolvedTypes)
        return parametersAndTypes.map { param, resolved in
            UseCasesParameter(label: param.label,
                name: param.name,
                type: param.type,
                resolvedType: resolved ?? UseCasesType(typeName: param.type),
                text_: param.text)
        }
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
