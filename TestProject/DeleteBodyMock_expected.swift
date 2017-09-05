@testable import TestProject

class DeleteBodyMock: DeleteBody {
    var invokedMethod = false
    var invokedMethodCount = 0
    func method() {
        invokedMethod = true
        invokedMethodCount += 1
    }
}
