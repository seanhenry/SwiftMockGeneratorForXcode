import XCTest
@testable import SwiftStructureInterface

class ExplicitMemberExpressionParserTests: XCTestCase {

    func test_shouldParseIntegerExpression() throws {
        let text = "expression.0"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseWithFloatingPoint() throws {
        XCTAssertThrowsError(try parse("expression.0.0"))
    }

    func test_shouldNotParseMissingPostfixExpression() throws {
        XCTAssertThrowsError(try parse(".0"))
    }

    func test_shouldNotParseMissingDot() throws {
        XCTAssertThrowsError(try parse("expression 0"))
    }

    func test_shouldNotParseMissingExplicitMember() throws {
        XCTAssertThrowsError(try parse("expression."))
    }

    func test_shouldParseExpressionWithIdentifier() throws {
        let text = "expression.identifier"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionWithGenericArgumentClause() throws {
        let text = "expression.identifier<T>"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionWithArgumentNames() throws {
        let text = "expression.identifier(name:)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseWhenMissingTrailingParen() {
        XCTAssertEqual(try parse("expression.identifier(").text, "expression.identifier")
    }

    func test_shouldNotParseArgumentNamesWhenGenericClauseIsPresent() {
        XCTAssertEqual(try parse("expression.identifier<T>()").text, "expression.identifier<T>")
    }

    private func parse(_ input: String) throws -> ExplicitMemberExpression {
        return try createCompoundPostfixExpressionParser(input, ExplicitMemberExpressionParser.self).parse()
    }
}
