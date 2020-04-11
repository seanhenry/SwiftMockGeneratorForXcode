@testable import TestProject

class ReadOnlySubscriptProtocolMock: ReadOnlySubscriptProtocol {

    var invokedSubscriptGetter = false
    var invokedSubscriptGetterCount = 0
    var stubbedSubscriptResult: Int! = 0

    subscript() -> Int {
        invokedSubscriptGetter = true
        invokedSubscriptGetterCount += 1
        return stubbedSubscriptResult
    }
}
