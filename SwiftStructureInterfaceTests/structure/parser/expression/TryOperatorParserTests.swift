import XCTest
@testable import SwiftStructureInterface

class TryOperatorParserTests: XCTestCase {

    func test_shouldParseOperator() throws {
        let text = "try"
        let op = try parse(text)
        XCTAssertEqual(op.text, text)
    }

    func test_shouldParseOptionalOperator() throws {
        let text = "try?"
        let op = try parse(text)
        XCTAssertEqual(op.text, text)
    }

    func test_shouldParseForcedOperator() throws {
        let text = "try!"
        let op = try parse(text)
        XCTAssertEqual(op.text, text)
    }

    func test_shouldNotParseMissingKeyword() {
        XCTAssertThrowsError(try parse("not try"))
    }

    private func parse(_ input: String) throws -> TryOperator {
        return try createParser(input, TryOperatorParser.self).parse()
    }
}
