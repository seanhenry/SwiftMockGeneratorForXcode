@testable import TestProject

class TypealiasProtocolMock: TypealiasProtocol {

    var invokedTypealiasClosure = false
    var invokedTypealiasClosureCount = 0
    var stubbedTypealiasClosureClosureResult: (Int, Void)?

    func typealiasClosure(closure: TypealiasProtocolCompletion) {
        invokedTypealiasClosure = true
        invokedTypealiasClosureCount += 1
        if let result = stubbedTypealiasClosureClosureResult {
            _ = closure(result.0)
        }
    }

    var invokedTypealiasedTypealiasClosure = false
    var invokedTypealiasedTypealiasClosureCount = 0
    var stubbedTypealiasedTypealiasClosureClosureResult: (Int, Void)?

    func typealiasedTypealiasClosure(closure: TypealiasedTypealiasProtocolCompletion) {
        invokedTypealiasedTypealiasClosure = true
        invokedTypealiasedTypealiasClosureCount += 1
        if let result = stubbedTypealiasedTypealiasClosureClosureResult {
            _ = closure(result.0)
        }
    }

    var invokedInternalTypealiasClosure = false
    var invokedInternalTypealiasClosureCount = 0
    var stubbedInternalTypealiasClosureClosureResult: (String, Void)?

    func internalTypealiasClosure(closure: T) {
        invokedInternalTypealiasClosure = true
        invokedInternalTypealiasClosureCount += 1
        if let result = stubbedInternalTypealiasClosureClosureResult {
            closure(result.0)
        }
    }

    var invokedEscapingClosure = false
    var invokedEscapingClosureCount = 0
    var stubbedEscapingClosureClosureResult: (Int, Void)?

    func escapingClosure(closure: @escaping TypealiasProtocolCompletion) {
        invokedEscapingClosure = true
        invokedEscapingClosureCount += 1
        if let result = stubbedEscapingClosureClosureResult {
            _ = closure(result.0)
        }
    }
}
