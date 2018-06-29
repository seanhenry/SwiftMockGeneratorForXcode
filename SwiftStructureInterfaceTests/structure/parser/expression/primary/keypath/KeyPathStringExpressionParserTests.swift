import XCTest
@testable import SwiftStructureInterface

class KeyPathStringExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "#keyPath(expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseExpressionMissingHash() {
        XCTAssertThrowsError(try parse("keyPath(expression)"))
    }

    func test_shouldNotParseExpressionMissingKeyPath() {
        XCTAssertThrowsError(try parse("#identifier(expression)"))
    }

    func test_shouldParseExpressionMissingLeadingParen() throws {
        let text = "#keyPath expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionMissingTrailingParen() throws {
        let text = "#keyPath(expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionMissingExpressionArgument() throws {
        let text = "#keyPath()"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    private func parse(_ input: String) throws -> KeyPathStringExpression {
        return try createParser(input, KeyPathStringExpressionParser.self).parse()
    }
}
