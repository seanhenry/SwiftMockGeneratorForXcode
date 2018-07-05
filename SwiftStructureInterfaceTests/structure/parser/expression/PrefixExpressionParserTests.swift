import XCTest
@testable import SwiftStructureInterface

class PrefixExpressionParserTests: XCTestCase {

    func test_shouldParseInOutExpression() throws {
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

    private func parse(_ input: String) throws -> PrefixExpression {
        return try createParser(input, PrefixExpressionParser.self).parse()
    }
}
