@testable import SwiftStructureInterface

class MockElementVisitor: ElementVisitor {

    var invokedVisitSwiftElement = false
    var invokedVisitSwiftElementCount = 0
    var invokedVisitSwiftElementParameters: (element: SwiftElement, Void)?
    var invokedVisitSwiftElementParametersList = [(element: SwiftElement, Void)]()

    func visit(_ element: SwiftElement) {
        invokedVisitSwiftElement = true
        invokedVisitSwiftElementCount += 1
        invokedVisitSwiftElementParameters = (element, ())
        invokedVisitSwiftElementParametersList.append((element, ()))
    }

    var invokedVisitSwiftTypeElement = false
    var invokedVisitSwiftTypeElementCount = 0
    var invokedVisitSwiftTypeElementParameters: (element: SwiftTypeElement, Void)?
    var invokedVisitSwiftTypeElementParametersList = [(element: SwiftTypeElement, Void)]()

    func visit(_ element: SwiftTypeElement) {
        invokedVisitSwiftTypeElement = true
        invokedVisitSwiftTypeElementCount += 1
        invokedVisitSwiftTypeElementParameters = (element, ())
        invokedVisitSwiftTypeElementParametersList.append((element, ()))
    }

    var invokedVisitSwiftFile = false
    var invokedVisitSwiftFileCount = 0
    var invokedVisitSwiftFileParameters: (element: SwiftFile, Void)?
    var invokedVisitSwiftFileParametersList = [(element: SwiftFile, Void)]()

    func visit(_ element: SwiftFile) {
        invokedVisitSwiftFile = true
        invokedVisitSwiftFileCount += 1
        invokedVisitSwiftFileParameters = (element, ())
        invokedVisitSwiftFileParametersList.append((element, ()))
    }
}
