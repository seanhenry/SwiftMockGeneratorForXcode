import XCTest
@testable import SwiftStructureInterface

class OptionalChainingExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "expression?"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseMissingPostfixExpression() {
        XCTAssertThrowsError(try parse("class?"))
    }

    func test_shouldNotParseMissingQuestion() {
        XCTAssertThrowsError(try parse("expression"))
    }

    private func parse(_ input: String) throws -> OptionalChainingExpression {
        return try createCompoundPostfixExpressionParser(input, OptionalChainingExpressionParser.self).parse()
    }
}
