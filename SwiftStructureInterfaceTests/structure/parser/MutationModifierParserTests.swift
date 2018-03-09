import XCTest
@testable import SwiftStructureInterface

class MutationModifierParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseMutationModifiers() {
        let modifiers = [
            "mutating",
            "nonmutating"
        ]
        modifiers.forEach { d in
            XCTAssertEqual(parse(d), d)
        }
    }

    // MARK: - Helpers

    func parse(_ text: String) -> String {
        return createParser(text, MutationModifierParser.self).parse()
    }
}
