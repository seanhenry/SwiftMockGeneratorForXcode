import XCTest
@testable import SwiftStructureInterface

class StrictIdentifierParserTests: XCTestCase {

    func test_shouldParseIdentifier() {
        XCTAssertEqual(try parse("identifier").text, "identifier")
    }

    func test_shouldParseUnderscore() {
        XCTAssertEqual(try parse("_").text, "_")
    }

    func test_shouldAdvanceLexer() {
        let parser = createParser("identifier1 identifier2", StrictIdentifierParser.self)
        XCTAssertEqual(try parser.parse().text, "identifier1")
        XCTAssertEqual(try parser.parse().text, "identifier2")
    }

    func test_shouldThrowsWhenNoIdentifier() {
        XCTAssertThrowsError(try parse("()"))
    }

    func test_shouldNotParseKeyword() {
        XCTAssertThrowsError(try parse("in"))
    }

    func test_shouldParseEscapedIdentifier() {
        XCTAssertEqual(try parse("`func`").text, "`func`")
    }

    private func parse(_ input: String) throws -> Identifier {
        return try createParser(input, StrictIdentifierParser.self).parse()
    }
}
