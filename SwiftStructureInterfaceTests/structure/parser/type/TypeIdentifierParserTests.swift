import XCTest
@testable import SwiftStructureInterface

class TypeIdentifierParserTests: XCTestCase, TypeParserTests {

    // MARK: - parse

    func test_parse_shouldParseSimpleType() {
        assertTypeText("Int", "Int")
    }

    func test_parse_shouldParseEmptyTypeAsError() {
        let element = createParser("", TypeParser.self).parse()
        XCTAssert(element === TypeImpl.emptyType)
    }

    // MARK: - Nested

    func test_parse_shouldParseNestedType() {
        let text = "Swift.Int"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.typeName, "Int")
        XCTAssertEqual(type?.parentType?.text, "Swift")
        XCTAssertEqual(type?.parentType?.typeName, "Swift")
    }

    func test_parse_shouldParseDeeplyNestedType() {
        let text = "Swift.Deep.Nested.Int"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.typeName, "Int")
        var parent = type?.parentType
        XCTAssertEqual(parent?.text, "Swift.Deep.Nested")
        XCTAssertEqual(parent?.typeName, "Nested")
        parent = parent?.parentType
        XCTAssertEqual(parent?.text, "Swift.Deep")
        XCTAssertEqual(parent?.typeName, "Deep")
        parent = parent?.parentType
        XCTAssertEqual(parent?.text, "Swift")
        XCTAssertEqual(parent?.typeName, "Swift")
    }

    func test_parse_shouldParseNestedGenericType() {
        let text = "Swift<A>.Int<B>"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.typeName, "Int")
        XCTAssertEqual(type?.genericArgumentClause.arguments[0].text, "B")
        let parent = type?.parentType
        XCTAssertEqual(parent?.text, "Swift<A>")
        XCTAssertEqual(parent?.typeName, "Swift")
        XCTAssertEqual(parent?.genericArgumentClause.arguments[0].text, "A")
    }

    func test_parse_shouldParseTypeCompositionElement() {
        let text = "Swift.Int"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.genericArgumentClause.arguments.count, 0)
        let parent = type?.parentType
        assertElementText(parent, "Swift", offset: 0)
    }

    // MARK: - Generic

    func test_parse_shouldParseGenericType() {
        assertTypeText("Generic<Int>", "Generic<Int>")
    }

    func test_parse_shouldNotParseNonGenericOperator() {
        assertTypeText("Generic|Int>", "Generic")
    }

    func test_parse_shouldParseGenericTypeWithNestedInnerType() {
        assertTypeText("Generic<Nested.Int>", "Generic<Nested.Int>")
    }

    func test_parse_shouldParseIncompleteGenericType() {
        assertTypeText("Generic<", "Generic<")
    }

    func test_parse_shouldParseEmptyGenericType() {
        assertTypeText("Generic<>", "Generic<>")
    }

    func test_parse_shouldParseGenericWithMultipleArguments() {
        assertTypeText("Generic<A, B>", "Generic<A, B>")
    }

    func test_parse_shouldParseComplicatedGenericType() {
        assertTypeText("Nested.Generic<With.Nested.Generic<Inside.Another>, Side.By<Side, Again>>", "Nested.Generic<With.Nested.Generic<Inside.Another>, Side.By<Side, Again>>")
    }

    func test_parse_shouldParseWhitespaceOfGenericType() {
        assertTypeText("A < B , C >", "A < B , C >")
    }

    func test_parse_shouldParseGenericWithArrayType() {
        assertTypeText("Generic<[Int]>", "Generic<[Int]>")
    }

    func test_parse_shouldParseGenericWithDictionaryType() {
        assertTypeText("Generic<[Int:String]>", "Generic<[Int:String]>")
    }

    func test_parse_shouldParseGenericElement() {
        let text = "Generic<Int>"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.genericArgumentClause.arguments.count, 1)
        XCTAssertEqual(type?.typeName, "Generic")
        let element = type?.genericArgumentClause.arguments.first
        assertElementText(element, "Int", offset: 8)
    }

    func test_parse_shouldParseOptionalGenericElement() {
        let text = "Generic<Int>?"
        let type = parse(text) as? OptionalType
        let genericType = type?.type as? TypeIdentifier
        assertElementText(genericType, "Generic<Int>")
        XCTAssertEqual(genericType?.genericArgumentClause.arguments.count, 1)
        XCTAssertEqual(genericType?.typeName, "Generic")
        let element = genericType?.genericArgumentClause.arguments.first
        assertElementText(element, "Int", offset: 8)
    }

    func test_parse_shouldParseNestedGeneric() {
        let text = "G<T>.H<U>"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.genericArgumentClause.arguments.count, 1)
        XCTAssertEqual(type?.typeName, "H")
        var generic = type?.genericArgumentClause.arguments.first
        assertElementText(generic, "U", offset: 7)
        let parentType = type?.parentType
        assertElementText(parentType, "G<T>", offset: 0)
        XCTAssertEqual(parentType?.typeName, "G")
        generic = parentType?.genericArgumentClause.arguments.first
        assertElementText(generic, "T", offset: 2)
    }

    func test_parse_shouldParseDeepNestedGeneric() {
        let text = "G<T>.H<U>.I<V>"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.genericArgumentClause.arguments.count, 1)
        XCTAssertEqual(type?.typeName, "I")
        var generic = type?.genericArgumentClause.arguments.first
        assertElementText(generic, "V", offset: 12)
        var parentType = type?.parentType
        assertElementText(parentType, "G<T>.H<U>", offset: 0)
        XCTAssertEqual(parentType?.typeName, "H")
        generic = parentType?.genericArgumentClause.arguments.first
        assertElementText(generic, "U", offset: 7)
        parentType = parentType?.parentType
        assertElementText(parentType, "G<T>", offset: 0)
        XCTAssertEqual(parentType?.typeName, "G")
        generic = parentType?.genericArgumentClause.arguments.first
        assertElementText(generic, "T", offset: 2)
    }
}
