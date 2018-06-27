import XCTest
@testable import SwiftStructureInterface

class FunctionResultParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldFailWithEmptyResult() {
        XCTAssertThrowsError(try parse(""))
    }

    func test_parse_shouldFailWhenNoArrow() {
        XCTAssertThrowsError(try parse("A"))
    }

    func test_parse_shouldParseSimpleResult() throws {
        let text = "-> A"
        let result = try parse(text)
        assertElementText(result, text)
        assertElementText(result.type, "A")
    }

    func test_parse_shouldParseComplexType() throws {
        let text = "-> A.B<[Int?]>?"
        let result = try parse(text)
        assertElementText(result, text)
        assertElementText(result.type, "A.B<[Int?]>?")
    }

    func test_parse_shouldParseAttributesBeforeType() throws {
        let text = "-> @a @b(c) Int"
        let result = try parse(text)
        assertElementText(result, text)
        assertElementText(result.type, "Int")
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> FunctionResult {
        let parser = createParser(text, FunctionResultParser.self)
        return try parser.parse()
    }
}
