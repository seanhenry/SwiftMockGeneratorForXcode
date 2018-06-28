import XCTest
@testable import SwiftStructureInterface

class WildcardExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "_"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseExpressionWhenNotWildcard() {
        XCTAssertThrowsError(try parse("identifier"))
    }

    private func parse(_ input: String) throws -> WildcardExpression {
        return try createParser(input, WildcardExpressionParser.self).parse()
    }
}
