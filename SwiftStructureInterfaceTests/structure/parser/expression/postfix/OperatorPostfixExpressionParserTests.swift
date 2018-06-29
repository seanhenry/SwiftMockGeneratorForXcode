import XCTest
@testable import SwiftStructureInterface

class OperatorPostfixExpressionParserTests: XCTestCase {

    func test_shouldParseExpressionWithPostfixOperator() throws {
        let text = "self.expression++"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseExpressionWithBinaryOperator() {
        XCTAssertThrowsError(try parse("self.expression == expr"))
    }

    private func parse(_ input: String) throws -> OperatorPostfixExpression {
        return try createParser(input, OperatorPostfixExpressionParser.self).parse()
    }
}
