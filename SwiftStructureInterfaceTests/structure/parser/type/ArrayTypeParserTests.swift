import XCTest
@testable import SwiftStructureInterface

class ArrayTypeParserTests: XCTestCase, TypeParserTests {

    // MARK: - Array

    func test_parse_shouldParseArray() {
        assertTypeText("[Int]", "[Int]")
    }

    func test_parse_shouldParseArrayWithNestedType() {
        assertTypeText("[Nested.Type]", "[Nested.Type]")
    }

    func test_parse_shouldParseArrayWithGenericType() {
        assertTypeText("[Generic<Type>]", "[Generic<Type>]")
        assertTypeText("[Nested.Generic<Nested.Type>]", "[Nested.Generic<Nested.Type>]")
    }

    func test_parse_shouldParseArrayWithEmptyType() {
        assertTypeText("[]", "[]")
    }

    func test_parse_shouldNotParseArrayWithBadClosingType() {
        assertErrorType("[Type)")
    }

    func test_parse_shouldParse3DArray() {
        assertTypeText("[[[Int]]]", "[[[Int]]]")
    }

    func test_parse_shouldParseWhitespace() {
        assertTypeText("[ Int ]", "[ Int ]")
        assertTypeText("[ [ Int ] ]", "[ [ Int ] ]")
    }

    func test_parse_shouldParseArrayElement() {
        let text = "[Int]"
        let type = parse(text) as? ArrayType
        let element = type?.elementType
        assertElementText(type, text)
        assertElementText(element, "Int", offset: 1)
    }
}
