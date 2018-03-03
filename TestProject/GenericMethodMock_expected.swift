@testable import TestProject

class GenericMethodMock: GenericMethod {
    var invokedTestA = false
    var invokedTestACount = 0
    var invokedTestAParameters: (a: Any, Void)?
    var invokedTestAParametersList = [(a: Any, Void)]()
    func test<T>(a: T) {
        invokedTestA = true
        invokedTestACount += 1
        invokedTestAParameters = (a, ())
        invokedTestAParametersList.append((a, ()))
    }
    var invokedTestB = false
    var invokedTestBCount = 0
    var invokedTestBParameters: (b: Any, Void)?
    var invokedTestBParametersList = [(b: Any, Void)]()
    func test<T: NSObject>(b: T) {
        invokedTestB = true
        invokedTestBCount += 1
        invokedTestBParameters = (b, ())
        invokedTestBParametersList.append((b, ()))
    }
    var invokedTestC = false
    var invokedTestCCount = 0
    var invokedTestCParameters: (c: Any, Void)?
    var invokedTestCParametersList = [(c: Any, Void)]()
    func test<T: NSObject>(c: T.Type) {
        invokedTestC = true
        invokedTestCCount += 1
        invokedTestCParameters = (c, ())
        invokedTestCParametersList.append((c, ()))
    }
    var invokedTestReturn1 = false
    var invokedTestReturn1Count = 0
    var stubbedTestReturn1Result: Any!
    func testReturn1<T>() -> T? {
        invokedTestReturn1 = true
        invokedTestReturn1Count += 1
        return stubbedTestReturn1Result as? T
    }
    var invokedTestReturn2 = false
    var invokedTestReturn2Count = 0
    var stubbedTestReturn2Result: Any!
    func testReturn2<T>() -> T {
        invokedTestReturn2 = true
        invokedTestReturn2Count += 1
        return stubbedTestReturn2Result as! T
    }
    var invokedTestReturn3 = false
    var invokedTestReturn3Count = 0
    var stubbedTestReturn3Result: Any!
    func testReturn3<T: NSObject>() -> T {
        invokedTestReturn3 = true
        invokedTestReturn3Count += 1
        return stubbedTestReturn3Result as! T
    }
    var invokedTestD = false
    var invokedTestDCount = 0
    var invokedTestDParameters: (d: Any, Void)?
    var invokedTestDParametersList = [(d: Any, Void)]()
    func test<T: AssociatedTypeProtocol>(d: T) {
        invokedTestD = true
        invokedTestDCount += 1
        invokedTestDParameters = (d, ())
        invokedTestDParametersList.append((d, ()))
    }
    var invokedTestF = false
    var invokedTestFCount = 0
    var invokedTestFParameters: (f: Any?, g: Any?)?
    var invokedTestFParametersList = [(f: Any?, g: Any?)]()
    func test<T, U>(f: T!, g: U?) {
        invokedTestF = true
        invokedTestFCount += 1
        invokedTestFParameters = (f, g)
        invokedTestFParametersList.append((f, g))
    }
}
