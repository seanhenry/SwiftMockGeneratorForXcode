@testable import TestProject

class MockPropertyProtocol: PropertyProtocol {
    var invokedReadWriteSetter = false
    var invokedReadWriteSetterCount = 0
    var invokedReadWrite: String?
    var invokedReadWriteList = [String]()
    var invokedReadWriteGetter = false
    var invokedReadWriteGetterCount = 0
    var stubbedReadWrite: String!
    var readWrite: String {
        set {
            invokedReadWriteSetter = true
            invokedReadWriteSetterCount += 1
            invokedReadWrite = newValue
            invokedReadWriteList.append(newValue)
        }
        get {
            invokedReadWriteGetter = true
            invokedReadWriteGetterCount += 1
            return stubbedReadWrite
        }
    }
    var invokedReadOnlyGetter = false
    var invokedReadOnlyGetterCount = 0
    var stubbedReadOnly: Int!
    var readOnly: Int {
        invokedReadOnlyGetter = true
        invokedReadOnlyGetterCount += 1
        return stubbedReadOnly
    }
}
