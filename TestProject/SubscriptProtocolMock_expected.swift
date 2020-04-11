@testable import TestProject

class SubscriptProtocolMock: SubscriptProtocol {

    var invokedSubscriptGetter = false
    var invokedSubscriptGetterCount = 0
    var stubbedSubscriptResult: Int! = 0
    var invokedSubscriptSetter = false
    var invokedSubscriptSetterCount = 0
    var invokedSubscript: Int?
    var invokedSubscriptList = [Int]()

    subscript() -> Int {
        set {
            invokedSubscriptSetter = true
            invokedSubscriptSetterCount += 1
            invokedSubscript = newValue
            invokedSubscriptList.append(newValue)
        }
        get {
            invokedSubscriptGetter = true
            invokedSubscriptGetterCount += 1
            return stubbedSubscriptResult
        }
    }
}
