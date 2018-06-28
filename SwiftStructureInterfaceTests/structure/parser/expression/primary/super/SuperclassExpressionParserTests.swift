import XCTest
@testable import SwiftStructureInterface

class SuperclassExpressionParserTests: XCTestCase {

    func test_shouldNotParseSuperOnItsOwn() throws {
        XCTAssertThrowsError(try parse("super"))
    }

    func test_shouldParseSuperMethodExpression() throws {
        let text = "super.identifier"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is SuperclassMethodExpression)
    }

    func test_shouldParseSuperInitializerExpression() throws {
        let text = "super.init"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is SuperclassInitializerExpression)
    }

    // TODO: parse me
//    func test_shouldParseSuperSubscriptExpression() throws {
//        let text = "super[a: A, b: B]"
//        let expression = try parse(text)
//        XCTAssertEqual(expression.text, text)
//        XCTAssert(expression is SuperclassSubscriptExpression)
//    }

    private func parse(_ input: String) throws -> SuperclassExpression {
        return try createParser(input, SuperclassExpressionParser.self).parse()
    }
}
