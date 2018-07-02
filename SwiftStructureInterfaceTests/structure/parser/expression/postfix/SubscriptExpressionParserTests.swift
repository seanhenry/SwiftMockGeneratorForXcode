import XCTest
@testable import SwiftStructureInterface

class SubscriptExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "expression[name: expression]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseMissingPostfixExpression() {
        XCTAssertThrowsError(try parse("[expression]"))
    }

    func test_shouldNotParseMissingLeadingSquare() {
        XCTAssertThrowsError(try parse("expression expression]"))
    }

    func test_shouldNotParseMissingFunctionArgumentCallList() {
        XCTAssertThrowsError(try parse("expression[]"))
    }

    func test_shouldParseExpressionMissingTrailingSquare() throws {
        let text = "expression[expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    private func parse(_ input: String) throws -> SubscriptExpression {
        return try createCompoundPostfixExpressionParser(input, SubscriptExpressionParser.self).parse()
    }
}
