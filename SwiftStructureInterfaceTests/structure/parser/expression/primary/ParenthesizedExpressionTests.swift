import XCTest
@testable import SwiftStructureInterface

class ParenthesizedExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "(expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseExpressionWithoutParens() {
        XCTAssertThrowsError(try parse("expression)"))
        XCTAssertThrowsError(try parse("(expression"))
    }

    func test_shouldNotParseExpressionWithoutExpression() {
        XCTAssertThrowsError(try parse("()"))
    }

    private func parse(_ input: String) throws -> ParenthesizedExpression {
        return try createParser(input, ParenthesizedExpressionParser.self).parse()
    }
}
