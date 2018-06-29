import XCTest
@testable import SwiftStructureInterface

class IdentifierListParserTests: XCTestCase {

    func test_shouldParseIdentifier() throws {
        let text = "identifier"
        let identifier = try parse(text)
        XCTAssertEqual(identifier.text, text)
    }

    func test_shouldParseIdentifiers() throws {
        let text = "identifier1, identifier2, identifier3"
        let identifier = try parse(text)
        XCTAssertEqual(identifier.text, text)
    }

    func test_shouldParseWildcards() throws {
        let text = "_, _"
        let identifier = try parse(text)
        XCTAssertEqual(identifier.text, text)
    }

    func test_shouldNotParseNonIdentifier() {
        XCTAssertThrowsError(try parse("123"))
    }

    private func parse(_ input: String) throws -> IdentifierList {
        return try createParser(input, IdentifierListParser.self).parse()
    }
}
