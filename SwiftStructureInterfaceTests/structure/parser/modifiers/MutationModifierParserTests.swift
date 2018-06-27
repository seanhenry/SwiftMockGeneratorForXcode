import XCTest
@testable import SwiftStructureInterface

class MutationModifierParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseMutationModifiers() throws {
        let modifiers = [
            "mutating",
            "nonmutating"
        ]
        try modifiers.forEach { d in
            XCTAssertEqual(try parse(d), d)
        }
    }

    func test_parse_shouldNotParseAnythingElse() {
        XCTAssertThrowsError(try parse("public"))
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> String {
        return try createParser(text, MutationModifierParser.self).parse().text
    }
}
