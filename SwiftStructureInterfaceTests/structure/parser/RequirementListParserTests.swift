import XCTest
@testable import SwiftStructureInterface

class RequirementListParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyString() {
        XCTAssertThrowsError(try parse(""))
    }

    func test_parse_shouldParseConformanceRequirement() throws {
        let text = "A:B"
        let list = try parse(text)
        XCTAssertEqual(list.text, text)
        let requirement = list.requirements[0] as! ConformanceRequirement
        XCTAssertEqual(requirement.leftTypeIdentifier.text, "A")
        XCTAssertEqual(requirement.rightTypeIdentifier.text, "B")
    }

    func test_parse_shouldParseConformanceRequirementWithProtocolComposition() throws {
        let text = "A:B&C"
        let list = try parse(text)
        XCTAssertEqual(list.text, text)
        let requirement = list.requirements[0] as! ConformanceRequirement
        XCTAssertEqual(requirement.leftTypeIdentifier.text, "A")
        XCTAssertEqual(requirement.rightProtocolCompositionType.text, "B&C")
    }

    func test_parse_shouldParseSameTypeRequirement() throws {
        let text = "A==B"
        let list = try parse(text)
        XCTAssertEqual(list.text, text)
        let requirement = list.requirements[0] as! SameTypeRequirement
        XCTAssertEqual(requirement.leftTypeIdentifier.text, "A")
        XCTAssertEqual(requirement.rightType.text, "B")
    }

    func test_parse_shouldNotParseWrongColon() {
        XCTAssertThrowsError(try parse("A;B"))
    }

    func test_parse_shouldNotParseMissingRequirement() {
        XCTAssertThrowsError(try parse("A"))
    }

    func test_parse_shouldNotParseMultipleIncompleteConformances() {
        XCTAssertThrowsError(try parse("A,B;C"))
    }

    func test_parse_shouldParseFirstPartOfInvalidClause() {
        assertText("A:B,C;D", "A:B,")
        assertText("A==B,C=D", "A==B,")
    }

    func test_parse_shouldParseFirstPartOfInvalidRequirement() {
        assertText("A:", "A:")
        assertText("A==0", "A==")
    }

    func test_parse_shouldParseMultipleConformances() {
        assertText("A:B,C:D", "A:B,C:D")
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

    func test_parse_shouldParseWhitespaceInConformanceTypeRequirement(){
        assertText("A : B , C : D & E", "A : B , C : D & E")
    }

    // MARK: - Helpers

    func assertText(_ input: String, _ expected: String, line: UInt = #line) {
        XCTAssertEqual(try parse(input).text, expected, line: line)
    }

    func parse(_ input: String) throws -> RequirementList {
        return try createParser(input, RequirementListParser.self).parse()
    }
}
