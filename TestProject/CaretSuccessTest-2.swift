@testable import TestProject

class AnotherDeclarationInTheFileShouldNotBeAffected {

    func shouldNotInterfere() {

    }
}

class SimpleProtoc<selection></selection>olMock: SimpleProtocol {
    var anOldMock = false
    func anOldMockMethod() {
        anOldMock = true
        class Inner {

        }
    }
}
