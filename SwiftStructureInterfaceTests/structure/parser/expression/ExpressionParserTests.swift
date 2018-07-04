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
        _ = try parser.parseIdentifier()
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

    // TODO: parse binary expression

    private func parse(_ input: String) throws -> Expression {
        return try createParser(input, ExpressionParser.self).parse()
    }
}
