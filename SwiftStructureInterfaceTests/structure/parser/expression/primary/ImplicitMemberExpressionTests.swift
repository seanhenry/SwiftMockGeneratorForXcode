import XCTest
@testable import SwiftStructureInterface

class ImplicitMemberExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = ".identifier"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseKeywordIdentifier() throws {
        let text = ".right"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseExpressionWithoutLeadingDot() {
        XCTAssertThrowsError(try parse("identifier"))
    }

    func test_shouldNotParseExpressionWithoutIdentifier() {
        XCTAssertThrowsError(try parse(".123"))
    }

    private func parse(_ input: String) throws -> ImplicitMemberExpression {
        return try createParser(input, ImplicitMemberExpressionParser.self).parse()
    }
}
