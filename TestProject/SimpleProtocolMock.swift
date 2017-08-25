@testable import MockableTypes

class AnotherDeclarationInTheFileShouldNotBeAffected {
    
    func shouldNotInterfere() {
        
    }
}

class SimpleProtocolMock: SimpleProtocol {
    <caret>
}
