@testable import MockableTypes

class SuperclassMock: Superclass {
    var invokedSuperMethod = false
    var invokedSuperMethodCount = 0
    override func superMethod() {
        invokedSuperMethod = true
        invokedSuperMethodCount += 1
    }
    var invokedSuperSuperMethod = false
    var invokedSuperSuperMethodCount = 0
    override func superSuperMethod() {
        invokedSuperSuperMethod = true
        invokedSuperSuperMethodCount += 1
    }
}
