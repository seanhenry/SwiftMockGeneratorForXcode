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

    func test_parse_shouldParseNestedType() {
        assertTypeName("Swift.Type", "Swift.Type")
    }

    func test_parse_shouldParseDeeplyNestedType() {
        assertTypeName("Swift.Deep.Nested.Type", "Swift.Deep.Nested.Type")
    }

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

    func test_parse_shouldParseComplicatedType() {
        assertTypeName("Nested.Generic<With.Nested.Generic<Inside.Another>>", "Nested.Generic<With.Nested.Generic<Inside.Another>>")
    }

    // MARK: - Helpers

    func assertTypeName(_ input: String, _ expected: String, line: UInt = #line) {
        let element = createParser(input, TypeIdentifierParser.self).parse()
        XCTAssertEqual(element.name, expected, line: line)
    }
}
