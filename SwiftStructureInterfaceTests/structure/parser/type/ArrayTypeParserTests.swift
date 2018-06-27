import XCTest
@testable import SwiftStructureInterface

class ArrayTypeParserTests: XCTestCase, TypeParserTests {

    // MARK: - Array

    func test_parse_shouldParseArray() {
        assertTypeText("[Int]", "[Int]")
    }

    func test_parse_shouldParseArrayWithNestedType() {
        assertTypeText("[Nested.T]", "[Nested.T]")
    }

    func test_parse_shouldParseArrayWithGenericType() {
        assertTypeText("[Generic<Int>]", "[Generic<Int>]")
        assertTypeText("[Nested.Generic<Nested.T>]", "[Nested.Generic<Nested.T>]")
    }

    func test_parse_shouldParseArrayWithEmptyType() {
        assertTypeText("[]", "[]")
    }

    func test_parse_shouldNotParseArrayWithBadClosingType() {
        XCTAssertThrowsError(try parseArrayType("[T)"))
    }

    func test_parse_shouldParse3DArray() {
        assertTypeText("[[[Int]]]", "[[[Int]]]")
    }

    func test_parse_shouldParseWhitespace() {
        assertTypeText("[ Int ]", "[ Int ]")
        assertTypeText("[ [ Int ] ]", "[ [ Int ] ]")
    }

    func test_parse_shouldParseArrayElement() throws {
        let text = "[Int]"
        let type = try parseArrayType(text)
        let element = type.elementType
        assertElementText(type, text)
        assertElementText(element, "Int", offset: 1)
    }
}
