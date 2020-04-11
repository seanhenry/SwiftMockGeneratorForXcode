@testable import TestProject

class ReturnProtocolMock: ReturnProtocol {

    var invokedReturnType = false
    var invokedReturnTypeCount = 0
    var stubbedReturnTypeResult: String! = ""

    func returnType() -> String {
        invokedReturnType = true
        invokedReturnTypeCount += 1
        return stubbedReturnTypeResult
    }

    var invokedReturnTuple = false
    var invokedReturnTupleCount = 0
    var stubbedReturnTupleResult: (String, Int?)! = ("", nil)

    func returnTuple() -> (String, Int?) {
        invokedReturnTuple = true
        invokedReturnTupleCount += 1
        return stubbedReturnTupleResult
    }

    var invokedReturnLabelledTuple = false
    var invokedReturnLabelledTupleCount = 0
    var stubbedReturnLabelledTupleResult: (s: String, i: Int?)! = ("", nil)

    func returnLabelledTuple() -> (s: String, i: Int?) {
        invokedReturnLabelledTuple = true
        invokedReturnLabelledTupleCount += 1
        return stubbedReturnLabelledTupleResult
    }

    var invokedReturnOptional = false
    var invokedReturnOptionalCount = 0
    var stubbedReturnOptionalResult: Int!

    func returnOptional() -> Int? {
        invokedReturnOptional = true
        invokedReturnOptionalCount += 1
        return stubbedReturnOptionalResult
    }

    var invokedReturnIUO = false
    var invokedReturnIUOCount = 0
    var stubbedReturnIUOResult: UInt!

    func returnIUO() -> UInt! {
        invokedReturnIUO = true
        invokedReturnIUOCount += 1
        return stubbedReturnIUOResult
    }

    var invokedReturnGeneric = false
    var invokedReturnGenericCount = 0
    var stubbedReturnGenericResult: Optional<String>!

    func returnGeneric() -> Optional<String> {
        invokedReturnGeneric = true
        invokedReturnGenericCount += 1
        return stubbedReturnGenericResult
    }

    var invokedReturnOptionalGeneric = false
    var invokedReturnOptionalGenericCount = 0
    var stubbedReturnOptionalGenericResult: Optional<String>!

    func returnOptionalGeneric() -> Optional<String>? {
        invokedReturnOptionalGeneric = true
        invokedReturnOptionalGenericCount += 1
        return stubbedReturnOptionalGenericResult
    }

    var invokedReturnClosure = false
    var invokedReturnClosureCount = 0
    var stubbedReturnClosureResult: (() -> ())! = {}

    func returnClosure() -> () -> () {
        invokedReturnClosure = true
        invokedReturnClosureCount += 1
        return stubbedReturnClosureResult
    }

    var invokedReturnComplicatedClosure = false
    var invokedReturnComplicatedClosureCount = 0
    var stubbedReturnComplicatedClosureResult: ((String, Int?) -> (UInt))! = { _, _ in return 0 }

    func returnComplicatedClosure() -> ((String, Int?) -> (UInt)) {
        invokedReturnComplicatedClosure = true
        invokedReturnComplicatedClosureCount += 1
        return stubbedReturnComplicatedClosureResult
    }

    var invokedReturnOptionalClosure = false
    var invokedReturnOptionalClosureCount = 0
    var stubbedReturnOptionalClosureResult: (() -> ())!

    func returnOptionalClosure() -> (() -> ())? {
        invokedReturnOptionalClosure = true
        invokedReturnOptionalClosureCount += 1
        return stubbedReturnOptionalClosureResult
    }

    var invokedReturnExplicitVoid = false
    var invokedReturnExplicitVoidCount = 0
    var stubbedReturnExplicitVoidResult: Void! = ()

    func returnExplicitVoid() -> Void {
        invokedReturnExplicitVoid = true
        invokedReturnExplicitVoidCount += 1
        return stubbedReturnExplicitVoidResult
    }
}
