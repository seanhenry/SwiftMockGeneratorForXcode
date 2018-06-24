import XCTest
@testable import SwiftStructureInterface

class OptionalTypeParserTests: XCTestCase, TypeParserTests {

    // MARK: - Optional

    func test_parse_shouldParseOptional() {
        assertTypeText("Int?", "Int?")
    }

    func test_parse_shouldParseNestedTypeOptional() {
        assertTypeText("A.B.C?", "A.B.C?")
    }

    func test_parse_shouldParseGenericOptional() {
        assertTypeText("Generic<Int>?", "Generic<Int>?")
    }

    func test_parse_shouldParseOptionalArray() {
        assertTypeText("[Int?]?", "[Int?]?")
    }

    func test_parse_shouldParseOptionalDictionary() {
        assertTypeText("[[String?:Int?]?:Int?]?", "[[String?:Int?]?:Int?]?")
    }

    func test_parse_shouldParseOptionalElement() {
        let text = "Int?"
        let type = parse(text) as? OptionalType
        assertElementText(type, text)
        let innerType = type?.type
        assertElementText(innerType, "Int")
    }

    func test_parse_shouldParseDoubleOptionalElement() {
        let text = "Int??"
        let type = parse(text) as? OptionalType
        assertElementText(type, text)
        let innerOptional = type?.type as? OptionalType
        assertElementText(innerOptional, "Int?")
        let innerType = innerOptional?.type
        assertElementText(innerType, "Int")
    }

    // MARK: - IUO

    func test_parse_shouldParseIUO() {
        assertTypeText("Int!", "Int!")
    }

    func test_parse_shouldParseNestedTypeIUO() {
        assertTypeText("A.B.C!", "A.B.C!")
    }

    func test_parse_shouldParseGenericIUO() {
        assertTypeText("Generic<Int>!", "Generic<Int>!")
    }

    func test_parse_shouldParseIUOArray() {
        assertTypeText("[Int!]!", "[Int!]!")
    }

    func test_parse_shouldParseIUODictionary() {
        assertTypeText("[[String!:Int!]!:Int!]!", "[[String!:Int!]!:Int!]!")
    }

    func test_parse_shouldParseDoubleIUOElement() {
        let text = "Int!!"
        let type = parse(text) as? OptionalType
        assertElementText(type, "Int!!")
        let innerOptional = type?.type as? OptionalType
        assertElementText(innerOptional, "Int!")
        let innerType = innerOptional?.type
        assertElementText(innerType, "Int")
    }

    func test_parse_shouldParseDoubleOptionalAndIUOElement() {
        let text = "Int?!"
        let type = parse(text) as? OptionalType
        assertElementText(type, "Int?!")
        let innerOptional = type?.type as? OptionalType
        assertElementText(innerOptional, "Int?")
        let innerType = innerOptional?.type
        assertElementText(innerType, "Int")
    }
}
