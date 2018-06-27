import XCTest
@testable import SwiftStructureInterface

class AccessLevelModifierParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseAccessLevelModifiers() {
        let modifiers = [
            "private",
            "fileprivate",
            "internal",
            "public",
            "private(set)",
            "fileprivate(set)",
            "internal(set)",
            "public(set)",
            "open(set)"
        ]
        modifiers.forEach { d in
            assertText(d, d)
        }
    }

    func test_parse_shouldParseModifierWithMissingArgument() {
        assertText("public(", "public")
    }

    func test_parse_shouldReturnEmptyModifierWhenNoModifier() {
        XCTAssertThrowsError(try parse("not a modifier"))
    }

    // MARK: - Helpers

    func assertText(_ text: String, _ expected: String, line: UInt = #line) {
        XCTAssertEqual(try parse(text).text, expected, line: line)
    }

    func parse(_ text: String) throws -> AccessLevelModifier {
        return try createParser(text, AccessLevelModifierParser.self).parse()
    }
}
