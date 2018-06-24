import XCTest
@testable import SwiftStructureInterface

class IdentifierParserTests: XCTestCase {

    func test_shouldParseIdentifier() {
        XCTAssertEqual(parse("identifier").text, "identifier")
    }

    func test_shouldAdvanceLexer() {
        let parser = createParser("identifier1 identifier2", IdentifierParser.self)
        XCTAssertEqual(parser.parse().text, "identifier1")
        XCTAssertEqual(parser.parse().text, "identifier2")
    }

    func test_shouldReturnEmptyIdentifier() {
        XCTAssert(parse("()") === IdentifierImpl.emptyIdentifier)
    }

    func test_shouldParseEscapedIdentifier() {
        XCTAssertEqual(parse("`func`").text, "`func`")
    }

    private func parse(_ input: String) -> Identifier {
        return createParser(input, IdentifierParser.self).parse()
    }
}
