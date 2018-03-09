import XCTest
@testable import SwiftStructureInterface

class GenericWhereClauseParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyString() {
        assertText("", "")
    }

    func test_parse_shouldParseConformanceClause() {
        assertText("where A:B", "where A:B")
    }

    func test_parse_shouldParseSameTypeClause() {
        assertText("where A==B", "where A==B")
    }

    func test_parse_shouldParseMultipleConformances() {
        assertText("where A:B, C:D", "where A:B, C:D")
        assertText("where A==B, C==D", "where A==B, C==D")
    }

    // MARK: - Helpers

    func assertText(_ input: String, _ expected: String, line: UInt = #line) {
        let clause = createParser(input, GenericWhereClauseParser.self).parse()
        XCTAssertEqual(clause, expected, line: line)
    }
}
