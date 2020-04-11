@testable import TestProject

class AvailableClassMock: AvailableClass {

    var invokedPropertyGetter = false
    var invokedPropertyGetterCount = 0
    var stubbedProperty: String!

    override var property: String? {
        invokedPropertyGetter = true
        invokedPropertyGetterCount += 1
        return stubbedProperty
    }

    var invokedMethod = false
    var invokedMethodCount = 0

    override func method() {
        invokedMethod = true
        invokedMethodCount += 1
    }
}
