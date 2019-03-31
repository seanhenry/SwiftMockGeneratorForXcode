@testable import TestProject

class ClassSubscriptMock: ClassSubscript {
    var invokedSubscriptGetter = false
    var invokedSubscriptGetterCount = 0
    var stubbedSubscriptResult: Int! = 0
    override subscript() -> Int {
        invokedSubscriptGetter = true
        invokedSubscriptGetterCount += 1
        return stubbedSubscriptResult
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
    var invokedSubscriptDGetter = false
    var invokedSubscriptDGetterCount = 0
    var invokedSubscriptDGetterParameters: (d: Int, Void)?
    var invokedSubscriptDGetterParametersList = [(d: Int, Void)]()
    var stubbedSubscriptDResult: Int! = 0
    override subscript(d d: Int) -> Int {
        invokedSubscriptDGetter = true
        invokedSubscriptDGetterCount += 1
        invokedSubscriptDGetterParameters = (d, ())
        invokedSubscriptDGetterParametersList.append((d, ()))
        return stubbedSubscriptDResult
    }
}
