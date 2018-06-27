import XCTest
@testable import SwiftStructureInterface

class DeclarationModifierParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseDeclarationModifiers() throws {
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
        try modifiers.forEach { d in
            XCTAssertEqual(try parse(d), d)
        }
    }

    func test_parse_shouldParseUnownedSafe() {
        XCTAssertEqual(try parse("unowned(safe)"), "unowned(safe)")
    }

    func test_parse_shouldParseUnownedUnsafe() {
        XCTAssertEqual(try parse("unowned(unsafe)"), "unowned(unsafe)")
    }

    func test_parse_shouldParseAnyIdentifierInsideParens() {
        XCTAssertEqual(try parse("unowned(anything)"), "unowned(anything)")
    }

    func test_parse_shouldParseEmptyArguments() {
        XCTAssertEqual(try parse("unowned()"), "unowned()")
    }

    func test_parse_shouldParseMutationModifier() {
        XCTAssertEqual(try parse("mutating"), "mutating")
    }

    func test_parse_shouldParseAccessLevelModifiers() {
        XCTAssertEqual(try parse("public(set)"), "public(set)")
    }

    func test_parse_shouldNotParseNonModifier() {
        XCTAssertThrowsError(try parse("var"))
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> String {
        return try createParser(text, DeclarationModifierParser.self).parse().text
    }
}
