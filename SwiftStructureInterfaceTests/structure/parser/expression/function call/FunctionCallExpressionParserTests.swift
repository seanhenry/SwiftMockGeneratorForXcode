import XCTest
@testable import SwiftStructureInterface

class FunctionCallExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "self.expression(a: expression) { _ in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseWhenMissingPostfixExpression() {
        XCTAssertThrowsError(try parse("class"))
    }

    func test_shouldNotParseWhenMissingLeadingParen() {
        XCTAssertThrowsError(try parse("self.expression )"))
    }

    func test_shouldParseTrailingClosureWithoutArgumentList() throws {
        let text = "self.expression { }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseArgumentList() throws {
        let text = "self.expression(expr)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseArgumentListWithMissingTrailingParen() throws {
        let text = "self.expression(expr"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseEmptyArgumentList() throws {
        let text = "self.expression()"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    private func parse(_ input: String) throws -> FunctionCallExpression {
        return try createCompoundPostfixExpressionParser(input, FunctionCallExpressionParser.self).parse()
    }
}
