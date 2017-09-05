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
}
