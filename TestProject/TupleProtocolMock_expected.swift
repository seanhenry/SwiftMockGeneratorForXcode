@testable import TestProject

class TupleProtocolMock: TupleProtocol {

    var invokedTupleA = false
    var invokedTupleACount = 0
    var invokedTupleAParameters: (a: Void, Void)?
    var invokedTupleAParametersList = [(a: Void, Void)]()

    func tuple(a: ()) {
        invokedTupleA = true
        invokedTupleACount += 1
        invokedTupleAParameters = ((), ())
        invokedTupleAParametersList.append(((), ()))
    }

    var invokedTupleB = false
    var invokedTupleBCount = 0
    var invokedTupleBParameters: (b: (Void), Void)?
    var invokedTupleBParametersList = [(b: (Void), Void)]()

    func tuple(b: (Void)) {
        invokedTupleB = true
        invokedTupleBCount += 1
        invokedTupleBParameters = (b, ())
        invokedTupleBParametersList.append((b, ()))
    }

    var invokedTupleC = false
    var invokedTupleCCount = 0
    var invokedTupleCParameters: (c: (String, Int), Void)?
    var invokedTupleCParametersList = [(c: (String, Int), Void)]()

    func tuple(c: (String, Int)) {
        invokedTupleC = true
        invokedTupleCCount += 1
        invokedTupleCParameters = (c, ())
        invokedTupleCParametersList.append((c, ()))
    }

    var invokedTupleD = false
    var invokedTupleDCount = 0
    var invokedTupleDParameters: (d: (d0: String, d1: Int), Void)?
    var invokedTupleDParametersList = [(d: (d0: String, d1: Int), Void)]()

    func tuple(d: (d0: String, d1: Int)) {
        invokedTupleD = true
        invokedTupleDCount += 1
        invokedTupleDParameters = (d, ())
        invokedTupleDParametersList.append((d, ()))
    }

    var invokedTupleE = false
    var invokedTupleECount = 0
    var invokedTupleEParameters: (e: (e0: String, Int), Void)?
    var invokedTupleEParametersList = [(e: (e0: String, Int), Void)]()

    func tuple(e: (e0: String, Int)) {
        invokedTupleE = true
        invokedTupleECount += 1
        invokedTupleEParameters = (e, ())
        invokedTupleEParametersList.append((e, ()))
    }

    var invokedReturnEmpty = false
    var invokedReturnEmptyCount = 0
    var stubbedReturnEmptyResult: ()! = ()

    func returnEmpty() -> () {
        invokedReturnEmpty = true
        invokedReturnEmptyCount += 1
        return stubbedReturnEmptyResult
    }

    var invokedReturnVoid = false
    var invokedReturnVoidCount = 0
    var stubbedReturnVoidResult: (Void)! = ()

    func returnVoid() -> (Void) {
        invokedReturnVoid = true
        invokedReturnVoidCount += 1
        return stubbedReturnVoidResult
    }

    var invokedReturnTuple = false
    var invokedReturnTupleCount = 0
    var stubbedReturnTupleResult: (String, Int)! = ("", 0)

    func returnTuple() -> (String, Int) {
        invokedReturnTuple = true
        invokedReturnTupleCount += 1
        return stubbedReturnTupleResult
    }

    var invokedReturnLabelled = false
    var invokedReturnLabelledCount = 0
    var stubbedReturnLabelledResult: (a: String, b: Int)! = ("", 0)

    func returnLabelled() -> (a: String, b: Int) {
        invokedReturnLabelled = true
        invokedReturnLabelledCount += 1
        return stubbedReturnLabelledResult
    }

    var invokedReturnPartiallyLabelled = false
    var invokedReturnPartiallyLabelledCount = 0
    var stubbedReturnPartiallyLabelledResult: (a: String, b: Int)! = ("", 0)

    func returnPartiallyLabelled() -> (a: String, b: Int) {
        invokedReturnPartiallyLabelled = true
        invokedReturnPartiallyLabelledCount += 1
        return stubbedReturnPartiallyLabelledResult
    }
}
