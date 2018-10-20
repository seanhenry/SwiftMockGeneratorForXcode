@testable import TestProject

class PartialSpyClassMock: PartialSpyClass, PartialSpyProtocol {
    var invokedPropASetter = false
    var invokedPropASetterCount = 0
    var invokedPropA: Int?
    var invokedPropAList = [Int]()
    var invokedPropAGetter = false
    var invokedPropAGetterCount = 0
    var stubbedPropA: Int! = 0
    var forwardToOriginalPropA = false
    override var propA: Int {
        set {
            invokedPropASetter = true
            invokedPropASetterCount += 1
            invokedPropA = newValue
            invokedPropAList.append(newValue)
            if forwardToOriginalPropA {
                super.propA = newValue
            }
        }
        get {
            invokedPropAGetter = true
            invokedPropAGetterCount += 1
            if forwardToOriginalPropA {
                return super.propA
            }
            return stubbedPropA
        }
    }
    var invokedReadonlyGetter = false
    var invokedReadonlyGetterCount = 0
    var stubbedReadonly: Int! = 0
    var forwardToOriginalReadonly = false
    override var readonly: Int {
        invokedReadonlyGetter = true
        invokedReadonlyGetterCount += 1
        if forwardToOriginalReadonly {
            return super.readonly
        }
        return stubbedReadonly
    }
    var invokedProtocolPropertySetter = false
    var invokedProtocolPropertySetterCount = 0
    var invokedProtocolProperty: Int?
    var invokedProtocolPropertyList = [Int]()
    var invokedProtocolPropertyGetter = false
    var invokedProtocolPropertyGetterCount = 0
    var stubbedProtocolProperty: Int! = 0
    var protocolProperty: Int {
        set {
            invokedProtocolPropertySetter = true
            invokedProtocolPropertySetterCount += 1
            invokedProtocolProperty = newValue
            invokedProtocolPropertyList.append(newValue)
        }
        get {
            invokedProtocolPropertyGetter = true
            invokedProtocolPropertyGetterCount += 1
            return stubbedProtocolProperty
        }
    }
    var invokedProtocolReadonlyPropertyGetter = false
    var invokedProtocolReadonlyPropertyGetterCount = 0
    var stubbedProtocolReadonlyProperty: Int! = 0
    var protocolReadonlyProperty: Int {
        invokedProtocolReadonlyPropertyGetter = true
        invokedProtocolReadonlyPropertyGetterCount += 1
        return stubbedProtocolReadonlyProperty
    }
    var invokedMethod = false
    var invokedMethodCount = 0
    var forwardToOriginalMethod = false
    override func method() {
        invokedMethod = true
        invokedMethodCount += 1
        if forwardToOriginalMethod {
            super.method()
            return
        }
    }
    var invokedMethodA = false
    var invokedMethodACount = 0
    var invokedMethodAParameters: (a: Int, b: Int, d: Int)?
    var invokedMethodAParametersList = [(a: Int, b: Int, d: Int)]()
    var forwardToOriginalMethodA = false
    override func method(a: Int, _ b: Int, c d: Int) {
        invokedMethodA = true
        invokedMethodACount += 1
        invokedMethodAParameters = (a, b, d)
        invokedMethodAParametersList.append((a, b, d))
        if forwardToOriginalMethodA {
            super.method(a: a, b, c: d)
            return
        }
    }
    var invokedReturnMethod = false
    var invokedReturnMethodCount = 0
    var stubbedReturnMethodResult: Int! = 0
    var forwardToOriginalReturnMethod = false
    override func returnMethod() -> Int {
        invokedReturnMethod = true
        invokedReturnMethodCount += 1
        if forwardToOriginalReturnMethod {
            return super.returnMethod()
        }
        return stubbedReturnMethodResult
    }
    var invokedForwardNoStubs = false
    var invokedForwardNoStubsCount = 0
    var shouldInvokeForwardNoStubsA = false
    var stubbedForwardNoStubsError: Error?
    var forwardToOriginalForwardNoStubs = false
    override func forwardNoStubs(a: () -> ()) throws {
        invokedForwardNoStubs = true
        invokedForwardNoStubsCount += 1
        if forwardToOriginalForwardNoStubs {
            try super.forwardNoStubs(a: a)
            return
        }
        if shouldInvokeForwardNoStubsA {
            a()
        }
        if let error = stubbedForwardNoStubsError {
            throw error
        }
    }
    var invokedThrowing = false
    var invokedThrowingCount = 0
    var stubbedThrowingError: Error?
    var stubbedThrowingResult: Int! = 0
    var forwardToOriginalThrowing = false
    override func throwing() throws -> Int {
        invokedThrowing = true
        invokedThrowingCount += 1
        if forwardToOriginalThrowing {
            return try super.throwing()
        }
        if let error = stubbedThrowingError {
            throw error
        }
        return stubbedThrowingResult
    }
    var invokedRethrowing = false
    var invokedRethrowingCount = 0
    var shouldInvokeRethrowingA = false
    var stubbedRethrowingResult: Int! = 0
    var forwardToOriginalRethrowing = false
    override func rethrowing(a: () throws -> ()) rethrows -> Int {
        invokedRethrowing = true
        invokedRethrowingCount += 1
        if forwardToOriginalRethrowing {
            return try super.rethrowing(a: a)
        }
        if shouldInvokeRethrowingA {
            try? a()
        }
        return stubbedRethrowingResult
    }
    var invokedProtocolMethod = false
    var invokedProtocolMethodCount = 0
    func protocolMethod() {
        invokedProtocolMethod = true
        invokedProtocolMethodCount += 1
    }
}
