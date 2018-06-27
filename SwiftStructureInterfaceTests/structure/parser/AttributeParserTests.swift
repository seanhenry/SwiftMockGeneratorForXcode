import XCTest
@testable import SwiftStructureInterface

class AttributeParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseAttribute() throws {
        try assertAttributes("@attr", "@attr")
    }

    func test_parse_shouldNotParseEmptyString() throws {
        XCTAssertThrowsError(try parse(""))
    }

    func test_parse_shouldNotParseNonAttribute() throws {
        XCTAssertThrowsError(try parse("protocol NotAttribute {}"))
    }

    func test_parse_shouldParseAttributeWithMissingID() throws {
        try assertAttributes("@", "@")
    }

    func test_parse_shouldParseAttributeWithArgument() throws {
        try assertAttributes("@objc(test)", "@objc(test)")
    }

    func test_parse_shouldParseMutlitpleAttributes() throws {
        try assertAttributes("@abc @def @ghi", "@abc @def @ghi")
    }

    func test_parse_shouldParseMultipleAttributesWithArguments() throws {
        try assertAttributes("@objc(asd) @convention(c)", "@objc(asd) @convention(c)")
    }

    func test_parse_shouldParseMultipleMixedAttributes() throws {
        try assertAttributes("@abc @convention(c)", "@abc @convention(c)")
    }

    func test_parse_shouldNotParseClosure() throws {
        try assertAttributes("@escaping () -> ()", "@escaping")
    }

    // MARK: - Helpers

    func assertAttributes(_ input: String, _ expected: String, line: UInt = #line) throws {
        XCTAssertEqual(try parse(input).text, expected, line: line)
    }

    func parse(_ input: String) throws -> Attributes {
        return try createParser(input, AttributesParser.self).parse()
    }
}
