@testable import TestProject

class MockPropertyProtocol: PropertyProtocol {
    var invokedReadWriteSetter = false
    var invokedReadWriteSetterCount = 0
    var invokedReadWriteGetter = false
    var invokedReadWriteGetterCount = 0
    var stubbedReadWrite: String!
    var readWrite: String {
        set {
            invokedReadWriteSetter = true
            invokedReadWriteSetterCount += 1
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
    var invokedOptionalSetter = false
    var invokedOptionalSetterCount = 0
    var invokedOptionalGetter = false
    var invokedOptionalGetterCount = 0
    var stubbedOptional: UInt!
    var optional: UInt? {
        set {
            invokedOptionalSetter = true
            invokedOptionalSetterCount += 1
        }
        get {
            invokedOptionalGetter = true
            invokedOptionalGetterCount += 1
            return stubbedOptional
        }
    }
    var invokedUnwrappedSetter = false
    var invokedUnwrappedSetterCount = 0
    var invokedUnwrappedGetter = false
    var invokedUnwrappedGetterCount = 0
    var stubbedUnwrapped: String!
    var unwrapped: String! {
        set {
            invokedUnwrappedSetter = true
            invokedUnwrappedSetterCount += 1
        }
        get {
            invokedUnwrappedGetter = true
            invokedUnwrappedGetterCount += 1
            return stubbedUnwrapped
        }
    }
    var invokedWeakVarSetter = false
    var invokedWeakVarSetterCount = 0
    var invokedWeakVarGetter = false
    var invokedWeakVarGetterCount = 0
    var stubbedWeakVar: AnyObject!
    weak var weakVar: AnyObject? {
        set {
            invokedWeakVarSetter = true
            invokedWeakVarSetterCount += 1
        }
        get {
            invokedWeakVarGetter = true
            invokedWeakVarGetterCount += 1
            return stubbedWeakVar
        }
    }
    var invokedTupleSetter = false
    var invokedTupleSetterCount = 0
    var invokedTupleGetter = false
    var invokedTupleGetterCount = 0
    var stubbedTuple: (Int, String?)!
    var tuple: (Int, String?)? {
        set {
            invokedTupleSetter = true
            invokedTupleSetterCount += 1
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
