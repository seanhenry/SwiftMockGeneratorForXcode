@testable import TestProject

class MockPropertyProtocol: PropertyProtocol {

    var invokedReadWriteSetter = false
    var invokedReadWriteSetterCount = 0
    var invokedReadWrite: String?
    var invokedReadWriteList = [String]()
    var invokedReadWriteGetter = false
    var invokedReadWriteGetterCount = 0
    var stubbedReadWrite: String! = ""

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
    var stubbedReadOnly: Int! = 0

    var readOnly: Int {
        invokedReadOnlyGetter = true
        invokedReadOnlyGetterCount += 1
        return stubbedReadOnly
    }

    var invokedOptionalSetter = false
    var invokedOptionalSetterCount = 0
    var invokedOptional: UInt?
    var invokedOptionalList = [UInt?]()
    var invokedOptionalGetter = false
    var invokedOptionalGetterCount = 0
    var stubbedOptional: UInt!

    var optional: UInt? {
        set {
            invokedOptionalSetter = true
            invokedOptionalSetterCount += 1
            invokedOptional = newValue
            invokedOptionalList.append(newValue)
        }
        get {
            invokedOptionalGetter = true
            invokedOptionalGetterCount += 1
            return stubbedOptional
        }
    }

    var invokedUnwrappedSetter = false
    var invokedUnwrappedSetterCount = 0
    var invokedUnwrapped: String?
    var invokedUnwrappedList = [String?]()
    var invokedUnwrappedGetter = false
    var invokedUnwrappedGetterCount = 0
    var stubbedUnwrapped: String!

    var unwrapped: String! {
        set {
            invokedUnwrappedSetter = true
            invokedUnwrappedSetterCount += 1
            invokedUnwrapped = newValue
            invokedUnwrappedList.append(newValue)
        }
        get {
            invokedUnwrappedGetter = true
            invokedUnwrappedGetterCount += 1
            return stubbedUnwrapped
        }
    }

    var invokedTupleSetter = false
    var invokedTupleSetterCount = 0
    var invokedTuple: (Int, String?)?
    var invokedTupleList = [(Int, String?)?]()
    var invokedTupleGetter = false
    var invokedTupleGetterCount = 0
    var stubbedTuple: (Int, String?)!

    var tuple: (Int, String?)? {
        set {
            invokedTupleSetter = true
            invokedTupleSetterCount += 1
            invokedTuple = newValue
            invokedTupleList.append(newValue)
        }
        get {
            invokedTupleGetter = true
            invokedTupleGetterCount += 1
            return stubbedTuple
        }
    }

    var invokedMethod = false
    var invokedMethodCount = 0

    func method() {
        invokedMethod = true
        invokedMethodCount += 1
    }
}
