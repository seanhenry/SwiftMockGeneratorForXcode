import XCTest
@testable import SwiftStructureInterface

class BinaryExpressionParserTests: XCTestCase {

    func test_shouldParseBinaryOperatorExpression() throws {
        let text = "?? expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseMissingPrefixExpressionInBinaryOperatorExpression() {
        XCTAssertThrowsError(try parse("?? class"))
    }

    func test_shouldParseAssignmentExpression() throws {
        let text = "= expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseAssignmentExpressionWithTry() throws {
        let text = "= try? expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseMissingPrefixExpressionInAssignmentOperatorExpression() {
        XCTAssertThrowsError(try parse("= class"))
    }

    func test_shouldParseConditionalExpression() throws {
        let text = "? expression : expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseConditionalExpressionWithTry() throws {
        let text = "? expression : try? expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseMissingPrefixExpressionInConditionalOperatorExpression() {
        XCTAssertThrowsError(try parse("? expression : class"))
    }

    func test_shouldParseTypeCastingAsExpression() throws {
        let text = "as T"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseTypeCastingIsExpression() throws {
        let text = "is T"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    private func parse(_ input: String) throws -> BinaryExpression {
        return try createParser(input, BinaryExpressionParser.self).parse()
    }
}
