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
        let method = mapToUseCasesMethod(element: element)
        let resolved = getResolvedParameterTypeNames(element: element)
        let parameters = mapResolvedTypes(resolved, to: method)
        methods.append(addResolvedParameters(parameters, to: method))
    }

    private func mapToUseCasesMethod(element: SwiftMethodElement) -> UseCasesProtocolMethod {
        return UseCasesProtocolMethod(
            name: element.name,
            returnType: element.returnType,
            parameters: getParametersText(element: element) ?? "",
            signature: element.text)
    }

    private func getResolvedParameterTypeNames(element: SwiftMethodElement) -> [String?] {
        return element.parameters.map { ResolveUtil().resolveTypealias($0.type) }
    }

    private func mapResolvedTypes(_ resolvedNames: [String?], to method: UseCasesProtocolMethod) -> [UseCasesParameter] {
        let parametersAndTypes = zip(method.parametersList as! [UseCasesParameter], resolvedNames)
        return parametersAndTypes.map { (param, resolved) in
            UseCasesParameter(label: param.label,
                name: param.name,
                type: param.type,
                resolvedType: resolved ?? param.type,
                text: param.text)
        }
    }

    private func addResolvedParameters(_ parameters: [UseCasesParameter], to element: UseCasesProtocolMethod) -> UseCasesProtocolMethod {
        return UseCasesProtocolMethod(name: element.name,
            returnType: element.returnType,
            parametersList: parameters,
            signature: element.signature)
    }

    private func getParametersText(element: SwiftMethodElement) -> String? {
        var parameterString: String?
        if let firstParamStartIndex = element.parameters.first?.offset,
           let lastParam = element.parameters.last,
           let fileText = element.file?.text {
            let lastParamEndIndex = lastParam.offset - firstParamStartIndex + lastParam.length
            parameterString = getSubstring(from: fileText, offset: firstParamStartIndex, length: lastParamEndIndex)
        }
        return parameterString
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
