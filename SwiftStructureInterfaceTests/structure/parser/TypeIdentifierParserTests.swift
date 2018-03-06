import XCTest
@testable import SwiftStructureInterface

class TypeIdentifierParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseSimpleType() {
        assertTypeName("Type", "Type")
    }

    func test_parse_shouldParseEmptyTypeAsError() {
        let element = createParser("", TypeIdentifierParser.self).parse()
        XCTAssert(element === SwiftInheritedType.error)
    }

    // MARK: - Nested

    func test_parse_shouldParseNestedType() {
        assertTypeName("Swift.Type", "Swift.Type")
    }

    func test_parse_shouldParseDeeplyNestedType() {
        assertTypeName("Swift.Deep.Nested.Type", "Swift.Deep.Nested.Type")
    }

    // MARK: - Generic

    func test_parse_shouldParseGenericType() {
        assertTypeName("Generic<Type>", "Generic<Type>")
    }

    func test_parse_shouldNotParseNonGenericOperator() {
        assertTypeName("Generic|Type>", "Generic")
    }

    func test_parse_shouldParseNestedGenericType() {
        assertTypeName("Nested.Generic<Type>", "Nested.Generic<Type>")
        assertTypeName("Deep.Nested.Generic<Type>", "Deep.Nested.Generic<Type>")
    }

    func test_parse_shouldParseGenericTypeWithNestedInnerType() {
        assertTypeName("Generic<Nested.Type>", "Generic<Nested.Type>")
    }

    func test_parse_shouldParseIncompleteGenericType() {
        assertTypeName("Generic<", "Generic<")
    }

    func test_parse_shouldParseEmptyGenericType() {
        assertTypeName("Generic< >", "Generic<>")
    }

    func test_parse_shouldParseGenericWithMultipleArguments() {
        assertTypeName("Generic<A, B>", "Generic<A, B>")
    }

    func test_parse_shouldParseComplicatedType() {
        assertTypeName("Nested.Generic<With.Nested.Generic<Inside.Another>, Side.By<Side, Again>>", "Nested.Generic<With.Nested.Generic<Inside.Another>, Side.By<Side, Again>>")
    }

    func test_parse_shouldCalculateLengthWhenDifferentFormatting() {
        assertOffsetLength("A < B,C > next element", 0, 9)
    }

    // MARK: - Array

    func test_parse_shouldParseArray() {
        assertTypeName("[Int]", "[Int]")
    }

    func test_parse_shouldParseArrayWithNestedType() {
        assertTypeName("[Nested.Type]", "[Nested.Type]")
    }

    func test_parse_shouldParseArrayWithGenericType() {
        assertTypeName("[Generic<Type>]", "[Generic<Type>]")
        assertTypeName("[Nested.Generic<Nested.Type>]", "[Nested.Generic<Nested.Type>]")
    }

    func test_parse_shouldParseArrayWithEmptyType() {
        assertTypeName("[]", "[]")
    }

    func test_parse_shouldNotParseArrayWithBadClosingType() {
        assertTypeName("[Type)", "")
    }

    func test_parse_shouldParse3DArray() {
        assertTypeName("[[[Int]]]", "[[[Int]]]")
    }

    // MARK: - Helpers

    func assertTypeName(_ input: String, _ expected: String, line: UInt = #line) {
        let element = createParser(input, TypeIdentifierParser.self).parse()
        XCTAssertEqual(element.name, expected, line: line)
    }

    func assertOffsetLength(_ input: String, _ expectedOffset: Int64, _ expectedLength: Int64, line: UInt = #line) {
        let element = createParser(input, TypeIdentifierParser.self).parse()
        XCTAssertEqual(element.offset, expectedOffset, line: line)
        XCTAssertEqual(element.length, expectedLength, line: line)
    }
}
