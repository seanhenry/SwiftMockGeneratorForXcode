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
    var invokedAnotherMethod = false
    var invokedAnotherMethodCount = 0
    func anotherMethod(var1: String, var2: Int, var3: Double) {
        invokedAnotherMethod = true
        invokedAnotherMethodCount += 1
    }
}
