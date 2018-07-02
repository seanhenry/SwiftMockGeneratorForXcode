import XCTest
@testable import SwiftStructureInterface

class InitializerExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "expression.init"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseExpressionMissingPostfixExpression() {
        XCTAssertThrowsError(try parse(".init"))
    }

    func test_shouldNotParseExpressionMissingDot() {
        XCTAssertThrowsError(try parse("expression init"))
    }

    func test_shouldNotParseExpressionMissingKeyword() {
        XCTAssertThrowsError(try parse("expression."))
    }

    func test_shouldParseExpressionWithArgumentNames() throws {
        let text = "expression.init(name:name:)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionTree() throws {
        let text = "expression.init(name:)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssertEqual(expression.postfixExpression.text, "expression")
        XCTAssertEqual(expression.argumentNames?.text, "name:")
    }

    private func parse(_ input: String) throws -> InitializerExpression {
        return try createCompoundPostfixExpressionParser(input, InitializerExpressionParser.self).parse()
    }
}
