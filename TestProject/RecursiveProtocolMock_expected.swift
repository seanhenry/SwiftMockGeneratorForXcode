@testable import TestProject

class RecursiveProtocolMock: InheritingProtocol {

    var invokedInheriting = false
    var invokedInheritingCount = 0

    func inheriting() {
        invokedInheriting = true
        invokedInheritingCount += 1
    }

    var invokedInheritedOverloaded = false
    var invokedInheritedOverloadedCount = 0
    var invokedInheritedOverloadedParameters: (overloaded: Int, Void)?
    var invokedInheritedOverloadedParametersList = [(overloaded: Int, Void)]()

    func inherited(overloaded: Int) {
        invokedInheritedOverloaded = true
        invokedInheritedOverloadedCount += 1
        invokedInheritedOverloadedParameters = (overloaded, ())
        invokedInheritedOverloadedParametersList.append((overloaded, ()))
    }

    var invokedInheritedMethod = false
    var invokedInheritedMethodCount = 0
    var invokedInheritedMethodParameters: (method: String, Void)?
    var invokedInheritedMethodParametersList = [(method: String, Void)]()

    func inherited(method: String) {
        invokedInheritedMethod = true
        invokedInheritedMethodCount += 1
        invokedInheritedMethodParameters = (method, ())
        invokedInheritedMethodParametersList.append((method, ()))
    }
}
