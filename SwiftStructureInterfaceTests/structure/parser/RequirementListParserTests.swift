import XCTest
@testable import SwiftStructureInterface

class RequirementListParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyString() {
        assertText("", "")
    }

    func test_parse_shouldParseConformanceRequirement() {
        let text = "A:B"
        let list = parse(text)
        XCTAssertEqual(list.text, text)
        let requirement = list.requirements[0] as! ConformanceRequirement
        XCTAssertEqual(requirement.leftTypeIdentifier.text, "A")
        XCTAssertEqual(requirement.rightTypeIdentifier.text, "B")
    }

    func test_parse_shouldParseConformanceRequirementWithProtocolComposition() {
        let text = "A:B&C"
        let list = parse(text)
        XCTAssertEqual(list.text, text)
        let requirement = list.requirements[0] as! ConformanceRequirement
        XCTAssertEqual(requirement.leftTypeIdentifier.text, "A")
        XCTAssertEqual(requirement.rightProtocolCompositionType.text, "B&C")
    }

    func test_parse_shouldParseSameTypeRequirement() {
        let text = "A==B"
        let list = parse(text)
        XCTAssertEqual(list.text, text)
        let requirement = list.requirements[0] as! SameTypeRequirement
        XCTAssertEqual(requirement.leftTypeIdentifier.text, "A")
        XCTAssertEqual(requirement.rightType.text, "B")
    }

    func test_parse_shouldPartialParseWrongColon() {
        assertText("A;B", "A")
    }

    func test_parse_shouldPartialParseMissingConformance() {
        assertText("A", "A")
    }

    func test_parse_shouldParseMultipleConformances() {
        assertText("A:B,C:D", "A:B,C:D")
    }

    func test_parse_shouldTryToParseMultipleIncompleteConformances() {
        assertText("A,B;C", "A,B")
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

    func test_parse_shouldParseWhitespaceInSameTypeRequirement() {
        assertText("A == B , C == D", "A == B , C == D")
    }

    func test_parse_shouldParseWhitespaceInConformanceTypeRequirement() {
        assertText("A : B , C : D & E", "A : B , C : D & E")
    }

    // MARK: - Helpers

    func assertText(_ input: String, _ expected: String, line: UInt = #line) {
        XCTAssertEqual(parse(input).text, expected, line: line)
    }

    func parse(_ input: String) -> RequirementList {
        return createParser(input, RequirementListParser.self).parse()
    }
}
