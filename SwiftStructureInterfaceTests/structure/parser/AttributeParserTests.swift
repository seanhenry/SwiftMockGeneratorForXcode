import XCTest
@testable import SwiftStructureInterface

class AttributeParserTests: XCTestCase {

    var parser: Parser<String>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseAttribute() {
        assertAttributes("@attr", "@attr")
    }

    func test_parse_shouldNotParseEmptyString() {
        assertAttributes("", "")
    }

    func test_parse_shouldNotParseNonAttribute() {
        assertAttributes("protocol NotAttribute {}", "")
    }

    func test_parse_shouldParseAttributeWithMissingID() {
        assertAttributes("@", "@")
    }

    func test_parse_shouldParseAttributeWithArgument() {
        assertAttributes("@objc(test)", "@objc(test)")
    }

    func test_parse_shouldParseMutlitpleAttributes() {
        assertAttributes("@abc @def @ghi", "@abc @def @ghi")
    }

    func test_parse_shouldParseMultipleAttributesWithArguments() {
        assertAttributes("@objc(asd) @convention(c)", "@objc(asd) @convention(c)")
    }

    func test_parse_shouldParseMultipleMixedAttributes() {
        assertAttributes("@abc @convention(c)", "@abc @convention(c)")
    }

    // MARK: - Helpers

    func assertAttributes(_ input: String, _ expected: String, line: UInt = #line) {
        XCTAssertEqual(createParser(input, AttributeParser.self).parse(), expected, line: line)
    }
}
