@testable import TestProject

class ClassAndProtocolMock: ClassAndProtocol, ClassAndProtocolMockProtocol {

    convenience init() {
        self.init(shared: 0)
    }

    var invokedSharedPropertyGetter = false
    var invokedSharedPropertyGetterCount = 0
    var stubbedSharedProperty: String!

    override var sharedProperty: String? {
        invokedSharedPropertyGetter = true
        invokedSharedPropertyGetterCount += 1
        return stubbedSharedProperty
    }

    var invokedProtocolOnlyPropertyGetter = false
    var invokedProtocolOnlyPropertyGetterCount = 0
    var stubbedProtocolOnlyProperty: String!

    var protocolOnlyProperty: String? {
        invokedProtocolOnlyPropertyGetter = true
        invokedProtocolOnlyPropertyGetterCount += 1
        return stubbedProtocolOnlyProperty
    }

    var invokedSharedMethod = false
    var invokedSharedMethodCount = 0

    override func sharedMethod() {
        invokedSharedMethod = true
        invokedSharedMethodCount += 1
    }

    var invokedProtocolOnlyMethod = false
    var invokedProtocolOnlyMethodCount = 0

    func protocolOnlyMethod() {
        invokedProtocolOnlyMethod = true
        invokedProtocolOnlyMethodCount += 1
    }
}
