@testable import SwiftStructureInterface

class MethodGatheringVisitor: ElementVisitor {

    private let environment: JavaEnvironment
    private(set) var methods = [JavaProtocolMethodBridge]()
    private(set) var properties = [JavaProtocolPropertyBridge]()

    init(environment: JavaEnvironment) {
        self.environment = environment
    }

    func visit(_ element: SwiftElement) {
    }

    func visit(_ element: SwiftTypeElement) {
    }

    func visit(_ element: SwiftFile) {
    }

    func visit(_ element: SwiftMethodElement) {
        let parameterString = getParametersText(element: element)
        methods.append(JavaProtocolMethodBridge(javaEnvironment: environment, name: element.name, returnType: element.returnType, parameters: parameterString ?? "", signature: element.text))
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
        properties.append(JavaProtocolPropertyBridge(javaEnvironment: environment, name: element.name, type: element.type, isWritable: element.isWritable, signature: attribute + element.text))
    }
}
