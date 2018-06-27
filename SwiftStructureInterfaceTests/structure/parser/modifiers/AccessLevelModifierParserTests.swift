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
            XCTAssertEqual(getText(d), d)
        }
    }

    func test_parse_shouldParseModifierWithMissingArgument() {
        XCTAssertEqual(getText("public("), "public")
    }

    func test_parse_shouldReturnEmptyModifierWhenNoModifier() {
        XCTAssertThrowsError(try parse("not a modifier"))
    }

    // MARK: - Helpers

    func getText(_ text: String) -> String {
        return try! parse(text).text
    }

    func parse(_ text: String) throws -> AccessLevelModifier {
        return try createParser(text, AccessLevelModifierParser.self).parse()
    }
}
