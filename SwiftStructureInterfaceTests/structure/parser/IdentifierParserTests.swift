import XCTest
@testable import SwiftStructureInterface

class IdentifierParserTests: XCTestCase {

    func test_shouldParseIdentifier() {
        XCTAssertEqual(try parse("identifier").text, "identifier")
    }

    func test_shouldAdvanceLexer() {
        let parser = createParser("identifier1 identifier2", IdentifierParser.self)
        XCTAssertEqual(try parser.parse().text, "identifier1")
        XCTAssertEqual(try parser.parse().text, "identifier2")
    }

    func test_shouldThrowsWhenNoIdentifier() {
        XCTAssertThrowsError(try parse("()"))
    }

    func test_shouldParseEscapedIdentifier() {
        XCTAssertEqual(try parse("`func`").text, "`func`")
    }

    private func parse(_ input: String) throws -> Identifier {
        return try createParser(input, IdentifierParser.self).parse()
    }
}
