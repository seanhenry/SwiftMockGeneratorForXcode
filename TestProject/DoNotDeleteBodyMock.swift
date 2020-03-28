@testable import TestProject

class DoNotDeleteBodyMock: NotAValidProtocol {<selection></selection>
    // should not delete comments
    should not delete error statements
    func shouldNotDeleteFunctions() {

    }
    var shouldNotDeleteProperties = true
}
