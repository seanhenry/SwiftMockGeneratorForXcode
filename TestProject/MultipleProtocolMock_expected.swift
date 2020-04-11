@testable import TestProject

class MultipleProtocolMock: ProtocolA, ProtocolB, ProtocolC {

    var invokedA = false
    var invokedACount = 0

    func a() {
        invokedA = true
        invokedACount += 1
    }

    var invokedB = false
    var invokedBCount = 0

    func b() {
        invokedB = true
        invokedBCount += 1
    }

    var invokedC = false
    var invokedCCount = 0

    func c() {
        invokedC = true
        invokedCCount += 1
    }
}
