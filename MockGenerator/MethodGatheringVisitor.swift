@testable import SwiftStructureInterface

class MethodGatheringVisitor: ElementVisitor {

    let environment: JavaEnvironment
    var methods = [JavaProtocolMethodBridge]()
    
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
        methods.append(JavaProtocolMethodBridge(javaEnvironment: environment, name: element.name, signature: element.text))
    }
}
