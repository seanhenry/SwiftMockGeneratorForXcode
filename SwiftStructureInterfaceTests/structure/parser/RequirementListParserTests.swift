import XCTest
@testable import SwiftStructureInterface

class RequirementListParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyString() {
        assertText("", "")
    }

    func test_parse_shouldParseConformanceRequirement() {
        assertText("A:B", "A:B")
    }

    func test_parse_shouldParseSameTypeRequirement() {
        assertText("A==B", "A==B")
    }


    func test_parse_shouldPartialParseWrongColon() {
        assertText("A;B", "A")
    }

    func test_parse_shouldPartialParseMissingConformance() {
        assertText("A", "A")
    }

    func test_parse_shouldParseMultipleConformances() {
        assertText("A:B, C:D", "A:B, C:D")
    }

    func test_parse_shouldTryToParseMultipleIncompleteConformances() {
        assertText("A, B;C", "A, B")
    }

    func test_parse_shouldParseNestedTypes() {
        assertText("A.B.C:D.E.F", "A.B.C:D.E.F")
        assertText("A.B.C==D.E.F", "A.B.C==D.E.F")
    }

    func test_parse_shouldParseProtocolCompositionInConformanceRequirement() {
        assertText("A:B & C & D", "A:B & C & D")
    }

    func test_parse_shouldParseProtocolCompositionInSameTypeRequirement() {
        assertText("A==B & C & D", "A==B & C & D")
    }

    // MARK: - Helpers

    func assertText(_ input: String, _ expected: String, line: UInt = #line) {
        let requirement = createParser(input, RequirementListParser.self).parse()
        XCTAssertEqual(requirement, expected, line: line)
    }
}
