import XCTest
@testable import SwiftStructureInterface

class ExpressionParserTests: XCTestCase {

    func test_shouldParsePostfixExpression() throws {
        let text = "expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseInoutExpression() throws {
        let text = "&identifier"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParsePostfixExpressionWithPrefixOperator() throws {
        let text = "*expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseNotPostfixExpressionWithBinaryOperator() throws {
        let text = "expression * expression"
        let parser = createParser(text, ExpressionParser.self)
        _ = try parser.parseStrictIdentifier()
        XCTAssertThrowsError(try parser.parse())
    }

    func test_shouldParsePostfixExpressionWithBinaryOperatorContainingAmp() throws {
        let text = "*&expression"
        XCTAssertEqual(try parse(text).text, text)
    }

    func test_shouldParseTryAtBeginningOfExpression() throws {
        let text = "try expression"
        XCTAssertEqual(try parse(text).text, text)
    }

    func test_shouldParseBinaryExpression() throws {
        let text = "expression ?? expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseBinaryExpressions() throws {
        let text = "expression ?? expression ? expr : expr as! T"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    private func parse(_ input: String) throws -> Expression {
        return try createParser(input, ExpressionParser.self).parse()
    }
}
