@testable import TestProject

class AnotherDeclarationInTheFileShouldNotBeAffected {
    
    func shouldNotInterfere() {
        
    }
}

<selection></selection>class SimpleProtocolMock: SimpleProtocol {
    var anOldMock = false
    func anOldMockMethod() {
        anOldMock = true
        class Inner {

        }
    }
}
