import XCTest
@testable import SwiftStructureInterface

class InOutExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "&identifier"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseKeywordIdentifier() throws {
        let text = "&didSet"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseWithoutAmp() throws {
        XCTAssertThrowsError(try parse("identifier"))
    }

    func test_shouldNotParseWithoutIdentifier() throws {
        XCTAssertThrowsError(try parse("&0"))
    }

    func test_shouldNotParseAsPartOfALargerExpression() throws {
        let text = "in: &identifier"
        let parser = createParser(text, InOutExpressionParser.self)
        _ = try parser.parseKeyword(.in)
        _ = try parser.parsePunctuation(.colon)
        let expression = try parser.parse()
        XCTAssertEqual(expression.text, "&identifier")
    }

    private func parse(_ input: String) throws -> InOutExpression {
        return try createParser(input, InOutExpressionParser.self).parse()
    }
}


