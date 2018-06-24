import XCTest
@testable import SwiftStructureInterface

class DeclarationModifierParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseDeclarationModifiers() {
        let modifiers = [
            "class",
            "convenience",
            "dynamic",
            "final",
            "infix",
            "lazy",
            "optional",
            "override",
            "postfix",
            "prefix",
            "required",
            "static",
            "unowned",
            "weak"
        ]
        modifiers.forEach { d in
            XCTAssertEqual(parse(d), d)
        }
    }

    func test_parse_shouldParseUnownedSafe() {
        XCTAssertEqual(parse("unowned(safe)"), "unowned(safe)")
    }

    func test_parse_shouldParseUnownedUnsafe() {
        XCTAssertEqual(parse("unowned(unsafe)"), "unowned(unsafe)")
    }

    func test_parse_shouldParseMutationModifier() {
        XCTAssertEqual(parse("mutating"), "mutating")
    }

    func test_parse_shouldParseAccessLevelModifiers() {
        XCTAssertEqual(parse("public(set)"), "public(set)")
    }

    // MARK: - Helpers

    func parse(_ text: String) -> String {
        return createParser(text, DeclarationModifierParser.self).parse().text
    }
}
