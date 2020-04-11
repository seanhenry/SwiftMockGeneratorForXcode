@testable import TestProject

class MultipleVariableMock: MultipleVariable {

    var invokedASetter = false
    var invokedASetterCount = 0
    var invokedA: String?
    var invokedAList = [String]()
    var invokedAGetter = false
    var invokedAGetterCount = 0
    var stubbedA: String! = ""

    override var a: String {
        set {
            invokedASetter = true
            invokedASetterCount += 1
            invokedA = newValue
            invokedAList.append(newValue)
        }
        get {
            invokedAGetter = true
            invokedAGetterCount += 1
            return stubbedA
        }
    }
}
