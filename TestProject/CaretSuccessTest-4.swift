@testable import TestProject

class AnotherDeclarationInTheFileShouldNotBeAffected {
    
    func shouldNotInterfere() {
        
    }
}

class SimpleProtocolMock: SimpleProtocol {
    var anOldMock = false
    func anOldMockMethod() {
        anOldMock = true
        class Inner {

        }
    }
<selection></selection>}
