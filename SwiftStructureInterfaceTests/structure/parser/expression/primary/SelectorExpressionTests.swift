import XCTest
@testable import SwiftStructureInterface

class SelectorExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "#selector(expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseExpressionMissingHash() {
        XCTAssertThrowsError(try parse("selector(expression)"))
    }

    func test_shouldNotParseExpressionMissingSelectorKeyword() {
        XCTAssertThrowsError(try parse("#identifier(expression)"))
    }

    func test_shouldParseExpressionMissingLeadingParen() throws {
        let text = "#selector expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionMissingTrailingParen() throws {
        let text = "#selector(expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionMissingExpressionArgument() throws {
        let text = "#selector()"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionWithGetter() throws {
        let text = "#selector(getter: expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionWithSetter() throws {
        let text = "#selector(setter: expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    private func parse(_ input: String) throws -> SelectorExpression {
        return try createParser(input, SelectorExpressionParser.self).parse()
    }
}
