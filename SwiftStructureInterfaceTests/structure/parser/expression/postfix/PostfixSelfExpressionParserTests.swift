import XCTest
@testable import SwiftStructureInterface

class PostfixSelfExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "expression.self"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseMissingExpression() {
        XCTAssertThrowsError(try parse("class.self"))
    }

    func test_shouldNotParseMissingDot() {
        XCTAssertThrowsError(try parse("expression self"))
    }

    func test_shouldNotParseMissingSelf() {
        XCTAssertThrowsError(try parse("expression."))
    }

    func test_shouldNotParseCapitalizedSelf() {
        XCTAssertThrowsError(try parse("expression.Self"))
    }

    private func parse(_ input: String) throws -> PostfixSelfExpression {
        return try createParser(input, PostfixSelfExpressionParser.self).parse()
    }
}
