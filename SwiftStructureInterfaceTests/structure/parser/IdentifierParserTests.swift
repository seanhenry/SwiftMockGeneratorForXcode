import XCTest
@testable import SwiftStructureInterface

class IdentifierParserTests: XCTestCase {

    func test_shouldParseKeywordIdentifier() throws {
        let allowedKeywords = [
            "associativity",
            "convenience",
            "dynamic",
            "didSet",
            "final",
            "get",
            "infix",
            "indirect",
            "lazy",
            "left",
            "mutating",
            "none",
            "nonmutating",
            "optional",
            "override",
            "postfix",
            "precedence",
            "prefix",
            "Protocol",
            "required",
            "right",
            "set",
            "Type",
            "unowned",
            "weak",
            "willSet",
        ]
        try allowedKeywords.forEach { keyword in
            let identifier = try parse(keyword)
            XCTAssertEqual(identifier.text, keyword)
        }
    }

    func test_shouldParseNormalIdentifier() throws {
        let text = "identifier"
        let identifier = try parse(text)
        XCTAssertEqual(identifier.text, text)
    }

    func test_shouldParseUnderscoreIdentifier() throws {
        let text = "_"
        let identifier = try parse(text)
        XCTAssertEqual(identifier.text, text)
    }

    func test_shouldAdvanceAfterParsingKeyword() throws {
        let text = "set final"
        let parser = createParser(text, IdentifierParser.self)
        XCTAssertEqual(try parser.parse().text, "set")
        XCTAssertEqual(try parser.parse().text, "final")
    }

    func test_shouldNotParseDisallowedKeyword() {
        XCTAssertThrowsError(try parse("class"))
    }

    private func parse(_ input: String) throws -> Identifier {
        return try createParser(input, IdentifierParser.self).parse()
    }
}
