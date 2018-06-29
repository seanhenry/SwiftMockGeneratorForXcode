import XCTest
@testable import SwiftStructureInterface

class ForcedValueExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "expression!"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseMissingPostfixExpression() {
        XCTAssertThrowsError(try parse("class!"))
    }

    func test_shouldNotParseMissingExclamation() {
        XCTAssertThrowsError(try parse("expression"))
    }

    private func parse(_ input: String) throws -> ForcedValueExpression {
        return try createParser(input, ForcedValueExpressionParser.self).parse()
    }
}
