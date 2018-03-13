import XCTest
@testable import TestProject

class GenericMethodMockTests: XCTestCase {

    var genericMethod: GenericMethodMock!

    override func setUp() {
        super.setUp()
        genericMethod = GenericMethodMock()
    }

    override func tearDown() {
        genericMethod = nil
        super.tearDown()
    }

    // MARK: - closure

    func test_closure_shouldLegallyCastTypeInClosure() { // TODO: put me back when closures are supported
//        let string = "string"
//        genericMethod.stubbedTestClosureClosureResult = (string, ())
//        genericMethod.test { (result: String) -> String in
//            XCTAssertEqual(result, string)
//            return ""
//        }
    }

    func test_dictionary_shouldConvertStringToAnyHashable() {
        genericMethod.test(dictionary: ["a": 1])
        XCTAssertEqual(genericMethod.invokedTestDictionaryParameters?.dictionary["a"] as? Int, 1)
    }

    // MARK: - returnType

    func test_return_shouldLegallyCastTypeInOptionalReturnType() {
        XCTAssertNil(genericMethod.testReturn1())
        let string = "string"
        genericMethod.stubbedTestReturn1Result = string
        XCTAssertEqual(genericMethod.testReturn1(), string)
    }

    func test_return_shouldLegallyCastTypeInReturnType() {
        let string = "string"
        genericMethod.stubbedTestReturn2Result = string
        XCTAssertEqual(genericMethod.testReturn2(), string)
    }

    func test_return_shouldLegallyCastTypeInNSObjectReturnType() {
        let string = NSString(string: "string")
        genericMethod.stubbedTestReturn3Result = string
        XCTAssertEqual(genericMethod.testReturn3(), string)
    }

    func test_return_shouldLegallyCastDictionaryReturnType() {
        let dictionary = ["1": 2]
        genericMethod.stubbedTestReturnDictionaryResult = dictionary
        XCTAssertEqual(genericMethod.testReturnDictionary(), dictionary)
    }
}
