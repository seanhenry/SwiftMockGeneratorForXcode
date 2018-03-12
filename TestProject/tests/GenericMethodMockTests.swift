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

    func test_closure_shouldLegallyCastTypeInClosure() {
        let string = "string"
        genericMethod.stubbedTestClosureClosureResult = (string, ())
        genericMethod.test { (result: String) -> String in
            XCTAssertEqual(result, string)
            return ""
        }
    }

    // MARK: - returnType

    func test_closure_shouldLegallyCastTypeInOptionalReturnType() {
        XCTAssertNil(genericMethod.testReturn1())
        let string = "string"
        genericMethod.stubbedTestReturn1Result = string
        XCTAssertEqual(genericMethod.testReturn1(), string)
    }

    func test_closure_shouldLegallyCastTypeInReturnType() {
        let string = "string"
        genericMethod.stubbedTestReturn2Result = string
        XCTAssertEqual(genericMethod.testReturn2(), string)
    }

    func test_closure_shouldLegallyCastTypeInNSObjectReturnType() {
        let string = NSString(string: "string")
        genericMethod.stubbedTestReturn3Result = string
        XCTAssertEqual(genericMethod.testReturn3(), string)
    }
}
