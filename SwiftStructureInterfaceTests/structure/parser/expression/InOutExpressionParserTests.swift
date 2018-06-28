import XCTest
@testable import SwiftStructureInterface

class InOutExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "&identifier"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseWithoutAmp() throws {
        XCTAssertThrowsError(try parse("identifier"))
    }

    func test_shouldNotParseWithoutIdentifier() throws {
        XCTAssertThrowsError(try parse("&0"))
    }

    private func parse(_ input: String) throws -> InOutExpression {
        return try createParser(input, InOutExpressionParser.self).parse()
    }
}


