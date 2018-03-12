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
    var invokedTestE = false
    var invokedTestECount = 0
    var invokedTestEParameters: (e: Any, Void)?
    var invokedTestEParametersList = [(e: Any, Void)]()
    func test<T: AssociatedTypeProtocol>(e: T) where T.SomeType == NSObject {
        invokedTestE = true
        invokedTestECount += 1
        invokedTestEParameters = (e, ())
        invokedTestEParametersList.append((e, ()))
    }
    var invokedTestOptional = false
    var invokedTestOptionalCount = 0
    var invokedTestOptionalParameters: (optional: Any?, iuo: Any?)?
    var invokedTestOptionalParametersList = [(optional: Any?, iuo: Any?)]()
    func test<T, U>(optional: T?, iuo: U!) {
        invokedTestOptional = true
        invokedTestOptionalCount += 1
        invokedTestOptionalParameters = (optional, iuo)
        invokedTestOptionalParametersList.append((optional, iuo))
    }
    var invokedTestArray = false
    var invokedTestArrayCount = 0
    var invokedTestArrayParameters: (array: Any, Void)?
    var invokedTestArrayParametersList = [(array: Any, Void)]()
    func test<T>(array: [T]) {
        invokedTestArray = true
        invokedTestArrayCount += 1
        invokedTestArrayParameters = (array, ())
        invokedTestArrayParametersList.append((array, ()))
    }
    var invokedTestDictionary = false
    var invokedTestDictionaryCount = 0
    var invokedTestDictionaryParameters: (dictionary: Any, Void)?
    var invokedTestDictionaryParametersList = [(dictionary: Any, Void)]()
    func test<T, U>(dictionary: [T: U]) {
        invokedTestDictionary = true
        invokedTestDictionaryCount += 1
        invokedTestDictionaryParameters = (dictionary, ())
        invokedTestDictionaryParametersList.append((dictionary, ()))
    }
    var invokedTestClosure = false
    var invokedTestClosureCount = 0
    var stubbedTestClosureClosureResult: (Any, Void)?
    func test<T, U>(closure: (T) -> U) {
        invokedTestClosure = true
        invokedTestClosureCount += 1
        if let result = stubbedTestClosureClosureResult {
            _ = closure(result.0 as! T)
        }
    }
    var invokedTestTypeIdentifier = false
    var invokedTestTypeIdentifierCount = 0
    func test<T>(typeIdentifier: Generic<T>) {
        invokedTestTypeIdentifier = true
        invokedTestTypeIdentifierCount += 1
    }
    var invokedTestTuple = false
    var invokedTestTupleCount = 0
    var invokedTestTupleParameters: (tuple: Any, Void)?
    var invokedTestTupleParametersList = [(tuple: Any, Void)]()
    func test<T, U>(tuple: (T, U)) {
        invokedTestTuple = true
        invokedTestTupleCount += 1
        invokedTestTupleParameters = (tuple, ())
        invokedTestTupleParametersList.append((tuple, ()))
    }
}
