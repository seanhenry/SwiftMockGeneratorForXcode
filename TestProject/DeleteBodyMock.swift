@testable import TestProject

class DeleteBodyMock: DeleteBody {<caret>
    // should delete comments
    should delete error statements
    func shouldDeleteFunctions() {

    }
    var shouldDeleteProperties = true
}
