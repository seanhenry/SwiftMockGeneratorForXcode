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
        methods.append(JavaProtocolMethodBridge(javaEnvironment: environment, name: element.name, returnType: element.returnType, signature: element.text))
    }

    func visit(_ element: SwiftPropertyElement) {
        var attribute = ""
        if let elementAttribute = element.attribute {
            attribute = elementAttribute + " "
        }
        properties.append(JavaProtocolPropertyBridge(javaEnvironment: environment, name: element.name, type: element.type, isWritable: element.isWritable, signature: attribute + element.text))
    }
}
