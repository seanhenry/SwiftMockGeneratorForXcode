@testable import TestProject

class AugmentedClassSubscriptMock: AugmentedClassSubscript {

    var invokedSubscriptGetter = false
    var invokedSubscriptGetterCount = 0
    var stubbedSubscriptResult: Int! = 0
    var invokedSubscriptSetter = false
    var invokedSubscriptSetterCount = 0
    var invokedSubscript: Int?
    var invokedSubscriptList = [Int]()

    override subscript() -> Int {
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

    var invokedSubscriptBGetter = false
    var invokedSubscriptBGetterCount = 0
    var invokedSubscriptBGetterParameters: (b: Int, Void)?
    var invokedSubscriptBGetterParametersList = [(b: Int, Void)]()
    var stubbedSubscriptBResult: Int! = 0
    var invokedSubscriptBSetter = false
    var invokedSubscriptBSetterCount = 0
    var invokedSubscriptBSetterParameters: (b: Int, Void)?
    var invokedSubscriptBSetterParametersList = [(b: Int, Void)]()
    var invokedSubscriptB: Int?
    var invokedSubscriptBList = [Int]()

    override subscript(b: Int) -> Int {
        set {
            invokedSubscriptBSetter = true
            invokedSubscriptBSetterCount += 1
            invokedSubscriptBSetterParameters = (b, ())
            invokedSubscriptBSetterParametersList.append((b, ()))
            invokedSubscriptB = newValue
            invokedSubscriptBList.append(newValue)
        }
        get {
            invokedSubscriptBGetter = true
            invokedSubscriptBGetterCount += 1
            invokedSubscriptBGetterParameters = (b, ())
            invokedSubscriptBGetterParametersList.append((b, ()))
            return stubbedSubscriptBResult
        }
    }
}
