import XCTest
@testable import SwiftStructureInterface

class GenericWhereClauseParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldNotParseEmptyString() {
        XCTAssertThrowsError(try parse(""))
    }

    func test_parse_shouldNotParseRequirementWithMissingWhereKeyword() {
        XCTAssertThrowsError(try parse("A:B"))
    }

    func test_parse_shouldParseWhereClauseWithoutRequirements() {
        assertText("where 0", "where")
    }

    func test_parse_shouldParseConformanceClause() {
        assertText("where A:B", "where A:B")
    }

    func test_parse_shouldParseSameTypeClause() {
        assertText("where A==B", "where A==B")
    }

    func test_parse_shouldParseMultipleConformances() {
        assertText("where A:B,C:D", "where A:B,C:D")
        assertText("where A==B,C==D", "where A==B,C==D")
    }

    func test_parse_shouldParseWhitespace() {
        assertText("where A : B , C : D", "where A : B , C : D")
        assertText("where A == B , C == D ", "where A == B , C == D")
    }

    func test_parse_shouldParseRequirementsList() throws {
        let clause = try parse("where A:B")
        XCTAssertEqual(clause.requirementList.text, "A:B")
    }

    // MARK: - Helpers

    func assertText(_ input: String, _ expected: String, line: UInt = #line) {
        XCTAssertEqual(try parse(input).text, expected, line: line)
    }

    private func parse(_ input: String) throws -> GenericWhereClause {
        return try createParser(input, GenericWhereClauseParser.self).parse()
    }
}
