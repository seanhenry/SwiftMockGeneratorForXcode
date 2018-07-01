import XCTest
@testable import SwiftStructureInterface

class ArgumentNamesParserTests: XCTestCase {

    func test_shouldParseName() throws {
        let text = "name :"
        let names = try parse(text)
        XCTAssertEqual(names.text, text)
    }

    func test_shouldParseNames() throws {
        let text = "name:name2:"
        let names = try parse(text)
        XCTAssertEqual(names.text, text)
    }

    func test_shouldNotParseMissingName() {
        XCTAssertThrowsError(try parse(":"))
    }

    func test_shouldNotParseMissingColon() {
        XCTAssertThrowsError(try parse("name"))
    }

    func test_shouldParseTree() throws {
        let text = "name:name2:"
        let names = try parse(text)
        XCTAssertEqual(names.text, text)
        XCTAssertEqual(names.argumentNames.count, 2)
        XCTAssertEqual(names.argumentNames[0].text, "name:")
        XCTAssertEqual(names.argumentNames[1].text, "name2:")
    }

    private func parse(_ input: String) throws -> ArgumentNames {
        return try createParser(input, ArgumentNamesParser.self).parse()
    }
}
