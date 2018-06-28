import XCTest
@testable import SwiftStructureInterface

class IdentifierPrimaryExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "identifier<A: B>"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionWithOnlyIdentifier() throws {
        let text = "identifier"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseExpressionWithOnlyGenericClause() {
        XCTAssertThrowsError(try parse("<T>").text)
    }

    private func parse(_ input: String) throws -> IdentifierPrimaryExpression {
        return try createParser(input, IdentifierPrimaryExpressionParser.self).parse()
    }
}
