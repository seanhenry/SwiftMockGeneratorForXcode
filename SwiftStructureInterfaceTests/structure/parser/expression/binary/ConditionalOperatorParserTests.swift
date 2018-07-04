import XCTest
@testable import SwiftStructureInterface

class ConditionalOperatorParserTests: XCTestCase {

    func test_shouldParseOp() throws {
        let text = "? expression :"
        let op = try parse(text)
        XCTAssertEqual(op.text, text)
    }

    func test_shouldFailToParseMissingQuestion() {
        XCTAssertThrowsError(try parse("expression :"))
    }

    func test_shouldFailToParseMissingColon() {
        XCTAssertThrowsError(try parse("? expression "))
    }

    func test_shouldParseMissingExpression() throws {
        let text = "? :"
        let op = try parse(text)
        XCTAssertEqual(op.text, text)
    }

    private func parse(_ input: String) throws -> ConditionalOperator {
        return try createParser(input, ConditionalOperatorParser.self).parse()
    }
}
