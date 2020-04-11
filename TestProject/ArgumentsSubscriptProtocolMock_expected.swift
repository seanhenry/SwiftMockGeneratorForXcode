@testable import TestProject

class ArgumentsSubscriptProtocolMock: ArgumentsSubscriptProtocol {

    var invokedSubscriptGetter = false
    var invokedSubscriptGetterCount = 0
    var invokedSubscriptGetterParameters: (a: Int, Void)?
    var invokedSubscriptGetterParametersList = [(a: Int, Void)]()
    var stubbedSubscriptResult: Int! = 0
    var invokedSubscriptSetter = false
    var invokedSubscriptSetterCount = 0
    var invokedSubscriptSetterParameters: (a: Int, Void)?
    var invokedSubscriptSetterParametersList = [(a: Int, Void)]()
    var invokedSubscript: Int?
    var invokedSubscriptList = [Int]()

    subscript(a: Int) -> Int {
        set {
            invokedSubscriptSetter = true
            invokedSubscriptSetterCount += 1
            invokedSubscriptSetterParameters = (a, ())
            invokedSubscriptSetterParametersList.append((a, ()))
            invokedSubscript = newValue
            invokedSubscriptList.append(newValue)
        }
        get {
            invokedSubscriptGetter = true
            invokedSubscriptGetterCount += 1
            invokedSubscriptGetterParameters = (a, ())
            invokedSubscriptGetterParametersList.append((a, ()))
            return stubbedSubscriptResult
        }
    }
}
