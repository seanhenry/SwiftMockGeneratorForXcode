@testable import TestProject

class AnotherDeclarationInTheFileShouldNotBeAffected {

    func shouldNotInterfere() {

    }
}

class SimpleProtocolMock: SimpleProtocol {

    var invokedSimpleMethod = false
    var invokedSimpleMethodCount = 0

    func simpleMethod() {
        invokedSimpleMethod = true
        invokedSimpleMethodCount += 1
    }
}
