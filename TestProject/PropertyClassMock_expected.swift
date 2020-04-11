@testable import TestProject

class PropertyClassMock: PropertyClass {

    var invokedPropertySetter = false
    var invokedPropertySetterCount = 0
    var invokedProperty: String?
    var invokedPropertyList = [String?]()
    var invokedPropertyGetter = false
    var invokedPropertyGetterCount = 0
    var stubbedProperty: String!

    override var property: String? {
        set {
            invokedPropertySetter = true
            invokedPropertySetterCount += 1
            invokedProperty = newValue
            invokedPropertyList.append(newValue)
        }
        get {
            invokedPropertyGetter = true
            invokedPropertyGetterCount += 1
            return stubbedProperty
        }
    }

    var invokedComputedGetter = false
    var invokedComputedGetterCount = 0
    var stubbedComputed: Int! = 0

    override var computed: Int {
        invokedComputedGetter = true
        invokedComputedGetterCount += 1
        return stubbedComputed
    }

    var invokedPrivateSetGetter = false
    var invokedPrivateSetGetterCount = 0
    var stubbedPrivateSet: UInt!

    override var privateSet: UInt? {
        invokedPrivateSetGetter = true
        invokedPrivateSetGetterCount += 1
        return stubbedPrivateSet
    }

    var invokedFilePrivateSetGetter = false
    var invokedFilePrivateSetGetterCount = 0
    var stubbedFilePrivateSet: UInt!

    override var filePrivateSet: UInt? {
        invokedFilePrivateSetGetter = true
        invokedFilePrivateSetGetterCount += 1
        return stubbedFilePrivateSet
    }

    var invokedLazyPropertySetter = false
    var invokedLazyPropertySetterCount = 0
    var invokedLazyProperty: Int?
    var invokedLazyPropertyList = [Int]()
    var invokedLazyPropertyGetter = false
    var invokedLazyPropertyGetterCount = 0
    var stubbedLazyProperty: Int! = 0

    override var lazyProperty: Int {
        set {
            invokedLazyPropertySetter = true
            invokedLazyPropertySetterCount += 1
            invokedLazyProperty = newValue
            invokedLazyPropertyList.append(newValue)
        }
        get {
            invokedLazyPropertyGetter = true
            invokedLazyPropertyGetterCount += 1
            return stubbedLazyProperty
        }
    }
}
