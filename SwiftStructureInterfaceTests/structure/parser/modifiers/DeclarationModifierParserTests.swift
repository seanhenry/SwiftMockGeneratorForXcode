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

    func test_parse_shouldParseDeclarationModifierList() {
        XCTAssertEqual(parse("unowned(unsafe) required override"), "unowned(unsafe) required override")
    }

    func test_parse_shouldParseMutationAndAccessLevelModifiers() {
        XCTAssertEqual(parse("open public(set) override class mutating"), "open public(set) override class mutating")
    }

    // MARK: - Helpers

    func parse(_ text: String) -> String {
        return createParser(text, DeclarationModifierParser.self).parse()
    }
}
