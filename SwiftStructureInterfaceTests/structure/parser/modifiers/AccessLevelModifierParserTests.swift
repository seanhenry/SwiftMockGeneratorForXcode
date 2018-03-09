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
            "open(set)",
            "private(set)",
            "fileprivate(set)",
            "internal(set)",
            "public(set)",
            "open(set)"
        ]
        modifiers.forEach { d in
            XCTAssertEqual(parse(d), d)
        }
    }

    // MARK: - Helpers

    func parse(_ text: String) -> String {
        return createParser(text, AccessLevelModifierParser.self).parse()
    }
}
