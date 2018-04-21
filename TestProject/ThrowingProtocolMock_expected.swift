@testable import TestProject

class ThrowingProtocolMock: ThrowingProtocol {
    var invokedThrowingMethod = false
    var invokedThrowingMethodCount = 0
    var stubbedThrowingMethodError: Error?
    func throwingMethod() throws {
        invokedThrowingMethod = true
        invokedThrowingMethodCount += 1
        if let error = stubbedThrowingMethodError {
            throw error
        }
    }
    var invokedThrowingClosure = false
    var invokedThrowingClosureCount = 0
    var shouldInvokeThrowingClosureClosure = false
    func throwingClosure(closure: () throws -> ()) {
        invokedThrowingClosure = true
        invokedThrowingClosureCount += 1
        if shouldInvokeThrowingClosureClosure {
            try? closure()
        }
    }
    var invokedThrowingClosureArgument = false
    var invokedThrowingClosureArgumentCount = 0
    var stubbedThrowingClosureArgumentClosureResult: (String, Void)?
    func throwingClosureArgument(closure: (String) throws -> (String)) {
        invokedThrowingClosureArgument = true
        invokedThrowingClosureArgumentCount += 1
        if let result = stubbedThrowingClosureArgumentClosureResult {
            _ = try? closure(result.0)
        }
    }
    var invokedRethrowsMethod = false
    var invokedRethrowsMethodCount = 0
    var shouldInvokeRethrowsMethodClosure = false
    func rethrowsMethod(closure: () throws -> ()) rethrows {
        invokedRethrowsMethod = true
        invokedRethrowsMethodCount += 1
        if shouldInvokeRethrowsMethodClosure {
            try? closure()
        }
    }
}
