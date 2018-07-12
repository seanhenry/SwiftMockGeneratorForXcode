@testable import TestProject

class DefaultArgumentClassMock: DefaultArgumentClass {
    var invokedMethodWithDefaultArg = false
    var invokedMethodWithDefaultArgCount = 0
    var invokedMethodWithDefaultArgParameters: (with: String, defaultArg: Int)?
    var invokedMethodWithDefaultArgParametersList = [(with: String, defaultArg: Int)]()
    override func method(with: String, defaultArg: Int = 0) {
        invokedMethodWithDefaultArg = true
        invokedMethodWithDefaultArgCount += 1
        invokedMethodWithDefaultArgParameters = (with, defaultArg)
        invokedMethodWithDefaultArgParametersList.append((with, defaultArg))
    }
    var invokedMethodWithAllDefaultArgs = false
    var invokedMethodWithAllDefaultArgsCount = 0
    var invokedMethodWithAllDefaultArgsParameters: (with: String, allDefaultArgs: Int)?
    var invokedMethodWithAllDefaultArgsParametersList = [(with: String, allDefaultArgs: Int)]()
    override func method(with: String = "", allDefaultArgs: Int = 0) {
        invokedMethodWithAllDefaultArgs = true
        invokedMethodWithAllDefaultArgsCount += 1
        invokedMethodWithAllDefaultArgsParameters = (with, allDefaultArgs)
        invokedMethodWithAllDefaultArgsParametersList.append((with, allDefaultArgs))
    }
    var invokedMethod = false
    var invokedMethodCount = 0
    var stubbedMethodWithComplicatedDefaultResult: (String, Void)?
    override func method(withComplicatedDefault: (String) -> Int = { _ in return 0 }) {
        invokedMethod = true
        invokedMethodCount += 1
        if let result = stubbedMethodWithComplicatedDefaultResult {
            _ = withComplicatedDefault(result.0)
        }
    }
}
