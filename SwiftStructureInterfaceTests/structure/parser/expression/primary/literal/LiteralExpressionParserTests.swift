import XCTest
@testable import SwiftStructureInterface

class LiteralExpressionParserTests: XCTestCase {

    // MARK: - Keyword

    func test_shouldParseKeywordExpression() throws {
        let keywords = ["#file", "#line", "#column", "#function"]
        try keywords.forEach { text in
            XCTAssertEqual(try parse(text).text, text)
        }
    }

    func test_shouldNotParseKeywordExpressionMissingHash() {
        XCTAssertThrowsError(try parse("file"))
    }

    func test_shouldNotParseKeywordExpressionMissingKeyword() {
        XCTAssertThrowsError(try parse("#identifier"))
    }

    // MARK: - Playground

    func test_shouldParsePlaygroundLiteralExpression() throws {
        let keywords = ["#fileLiteral", "#imageLiteral"]
        try keywords.forEach { text in
            let fullText = "\(text)(resourceName: expression)"
            XCTAssertEqual(try parse(fullText).text, fullText)
        }
    }

    func test_shouldNotParsePlaygroundLiteralMissingHash() {
        XCTAssertThrowsError(try parse("fileLiteral"))
    }

    func test_shouldParsePlaygroundLiteralMissingLeadingParen() throws {
        let text = "#fileLiteral resourceName: expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParsePlaygroundLiteralMissingTrailingParen() throws {
        let text = "#fileLiteral(resourceName: expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParsePlaygroundLiteralMissingResourceName() throws {
        let text = "#fileLiteral(: expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParsePlaygroundLiteralMissingResourceNameColon() throws {
        let text = "#fileLiteral(resourceName expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParsePlaygroundLiteralMissingResourceNameExpression() throws {
        let text = "#fileLiteral(resourceName: )"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParsePlaygroundColorLiteralExpression() throws {
        let text = "#colorLiteral(red: expression, green: expression, blue: expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParsePlaygroundColorLiteralExpressionWithUnknownArguments() throws {
        let text = "#colorLiteral(alpha: expression, white: expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParsePlaygroundColorLiteralExpressionTree() throws {
        let text = "#colorLiteral(red: expression, green: expression, blue: expression)"
        let expression = try parse(text) as? PlaygroundLiteralExpression
        XCTAssertEqual(expression?.text, text)
        XCTAssertEqual(expression?.playgroundLiteralArguments.arguments.count, 3)
        XCTAssertEqual(expression?.playgroundLiteralArguments.arguments[0].text, "red: expression")
        XCTAssertEqual(expression?.playgroundLiteralArguments.arguments[1].text, "green: expression")
        XCTAssertEqual(expression?.playgroundLiteralArguments.arguments[2].text, "blue: expression")
    }

    // MARK: - Array

    func test_shouldParseArrayLiteralExpression() throws {
        let text = "[expression]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseArrayWithoutLeadingSquareBracket() {
        XCTAssertThrowsError(try parse("expression]"))
    }

    func test_shouldParseArrayWithoutTrailingSquareBracket() throws {
        let text = "[expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseArrayWithoutExpression() throws {
        let text = "[]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is ArrayLiteralExpression)
    }

    func test_shouldParseArrayWithManyExpressions() throws {
        let text = "[expression1, expression2]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseArrayWithTrailingComma() throws {
        let text = "[expression1, expression2,]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    // MARK: - Dictionary

    func test_shouldParseDictionaryLiteralExpression() throws {
        let text = "[expression : expression]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseDictionaryWithoutLeadingSquareBracket() {
        XCTAssertThrowsError(try parse("expression : expression]"))
    }

    func test_shouldNotParseDictionaryWithoutColon() throws {
        let expression = try parse("[expression expression]")
        XCTAssert(expression is ArrayLiteralExpression)
    }

    func test_shouldParseDictionaryWithoutTrailingSquareBracket() throws {
        let text = "[expression : expression"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseDictionaryWithoutExpression() throws {
        let text = "[:]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is DictionaryLiteralExpression)
    }

    func test_shouldParseDictionaryWithManyExpressions() throws {
        let text = "[expression1: expression2, expression3: expression4]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseDictionaryWithTrailingComma() throws {
        let text = "[expression1: expression2, expression3: expression4,]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    private func parse(_ input: String) throws -> LiteralExpression {
        return try createParser(input, LiteralExpressionParser.self).parse()
    }
}
