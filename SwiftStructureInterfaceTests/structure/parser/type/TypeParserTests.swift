import XCTest
@testable import SwiftStructureInterface

class TypeParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseSimpleType() {
        assertTypeText("Type", "Type")
    }

    func test_parse_shouldParseEmptyTypeAsError() {
        let element = createParser("", TypeParser.self).parse()
        XCTAssert(element === SwiftType.errorType)
    }

    // MARK: - Nested

    func test_parse_shouldParseNestedType() {
        assertTypeText("Swift.Type", "Swift.Type")
    }

    func test_parse_shouldParseDeeplyNestedType() {
        assertTypeText("Swift.Deep.Nested.Type", "Swift.Deep.Nested.Type")
    }

    func test_parse_shouldParseTypeCompositionElement() {
        let text = "Swift.Type"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.children.count, 1)
        XCTAssertEqual(type?.genericArguments.count, 0)
        let element = type?.type
        XCTAssert(type?.children.first === element)
        assertElementText(element, "Type", offset: 6)
    }

    // MARK: - Generic

    func test_parse_shouldParseGenericType() {
        assertTypeText("Generic<Type>", "Generic<Type>")
    }

    func test_parse_shouldNotParseNonGenericOperator() {
        assertTypeText("Generic|Type>", "Generic")
    }

    func test_parse_shouldParseNestedGenericType() {
        assertTypeText("Nested.Generic<Type>", "Nested.Generic<Type>")
        assertTypeText("Deep.Nested.Generic<Type>", "Deep.Nested.Generic<Type>")
    }

    func test_parse_shouldParseGenericTypeWithNestedInnerType() {
        assertTypeText("Generic<Nested.Type>", "Generic<Nested.Type>")
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

    func test_parse_shouldCalculateLengthWhenDifferentFormatting() {
        assertOffsetLength("A < B,C > next element", 0, 9)
    }

    func test_parse_shouldParseGenericWithArrayType() {
        assertTypeText("Generic<[Int]>", "Generic<[Int]>")
    }

    func test_parse_shouldParseGenericWithDictionaryType() {
        assertTypeText("Generic<[Int:String]>", "Generic<[Int:String]>")
    }

    func test_parse_shouldParseGenericElement() {
        let text = "Generic<Type>"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.children.count, 2)
        XCTAssertEqual(type?.genericArguments.count, 1)
        let element = type?.genericArguments.first
        XCTAssert(type?.children.last === element)
        assertElementText(element, "Type", offset: 8)
    }

    func test_parse_shouldParseOptionalGenericElement() {
        let text = "Generic<Type>?"
        let type = parse(text) as? OptionalType
        let genericType = type?.type as? TypeIdentifier
        assertElementText(genericType, "Generic<Type>")
        XCTAssertEqual(genericType?.children.count, 2)
        XCTAssertEqual(genericType?.genericArguments.count, 1)
        let element = genericType?.genericArguments.first
        XCTAssert(genericType?.children.last === element)
        assertElementText(element, "Type", offset: 8)
    }

    func test_parse_shouldParseNestedGeneric() {
        let text = "G<T>.H<U>"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.children.count, 2)
        XCTAssertEqual(type?.genericArguments.count, 1)
        let nestedType = type?.type
        XCTAssert(type?.children.first === nestedType)
        assertElementText(nestedType, "H", offset: 5)
        let generic = type?.genericArguments.first
        XCTAssert(type?.children.last === generic)
        assertElementText(generic, "U", offset: 7)
    }

    func test_parse_shouldParseDeepNestedGeneric() {
        let text = "G<T>.H<U>.I<V>"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.children.count, 2)
        XCTAssertEqual(type?.genericArguments.count, 1)
        let nestedType = type?.type
        XCTAssert(type?.children.first === nestedType)
        assertElementText(nestedType, "I", offset: 10)
        let generic = type?.genericArguments.first
        XCTAssert(type?.children.last === generic)
        assertElementText(generic, "V", offset: 12)
    }

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

    func test_parse_shouldParseArrayElement() {
        let text = "[Int]"
        let type = parse(text) as? ArrayType
        let element = type?.elementType
        assertElementText(type, text)
        XCTAssertEqual(type?.children.count, 1)
        XCTAssert(type?.children.first === element)
        assertElementText(element, "Int", offset: 1)
    }

    // MARK: - Dictionary

    func test_parse_shouldParseDictionary() {
        assertTypeText("[A:B]", "[A:B]")
    }

    func test_parse_shouldParseDictionaryWithNestedTypes() {
        assertTypeText("[A.B.C:D.E.F]", "[A.B.C:D.E.F]")
    }

    func test_parse_shouldParseDictionaryWithGenericTypes() {
        assertTypeText("[Generic<Type>:Generic<Type>]", "[Generic<Type>:Generic<Type>]")
    }

    func test_parse_shouldParseDictionaryWithArray() {
        assertTypeText("[[Int]:[String]]", "[[Int]:[String]]")
    }

    func test_parse_shouldParseDictionaryElement() {
        let text = "[Int: String]"
        let type = parse(text) as? DictionaryType
        assertElementText(type, text)
        XCTAssertEqual(type?.children.count, 2)
        let key = type?.keyType
        XCTAssert(type?.children.first === key)
        assertElementText(key, "Int", offset: 1)
        let value = type?.valueType
        XCTAssert(type?.children.last === value)
        assertElementText(value, "String", offset: 6)
    }

    // MARK: - Optional

    func test_parse_shouldParseOptional() {
        assertTypeText("Int?", "Int?")
    }

    func test_parse_shouldParseNestedTypeOptional() {
        assertTypeText("A.B.C?", "A.B.C?")
    }

    func test_parse_shouldParseGenericOptional() {
        assertTypeText("Generic<Type>?", "Generic<Type>?")
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
        XCTAssertEqual(type?.children.count, 1)
        let innerType = type?.type
        XCTAssert(type?.children.first === innerType)
        assertElementText(innerType, "Int")
    }

    func test_parse_shouldParseDoubleOptionalElement() {
        let text = "Int??"
        let type = parse(text) as? OptionalType
        assertElementText(type, text)
        XCTAssertEqual(type?.children.count, 1)
        let innerOptional = type?.type as? OptionalType
        XCTAssert(type?.children.first === innerOptional)
        assertElementText(innerOptional, "Int?")
        XCTAssertEqual(innerOptional?.children.count, 1)
        let innerType = innerOptional?.type
        XCTAssert(innerOptional?.children.first === innerType)
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
        assertTypeText("Generic<Type>!", "Generic<Type>!")
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
        XCTAssertEqual(type?.children.count, 1)
        let innerOptional = type?.type as? OptionalType
        XCTAssert(type?.children.first === innerOptional)
        assertElementText(innerOptional, "Int!")
        XCTAssertEqual(innerOptional?.children.count, 1)
        let innerType = innerOptional?.type
        XCTAssert(innerOptional?.children.first === innerType)
        assertElementText(innerType, "Int")
    }

    func test_parse_shouldParseDoubleOptionalAndIUOElement() {
        let text = "Int?!"
        let type = parse(text) as? OptionalType
        assertElementText(type, "Int?!")
        XCTAssertEqual(type?.children.count, 1)
        let innerOptional = type?.type as? OptionalType
        XCTAssert(type?.children.first === innerOptional)
        assertElementText(innerOptional, "Int?")
        XCTAssertEqual(innerOptional?.children.count, 1)
        let innerType = innerOptional?.type
        XCTAssert(innerOptional?.children.first === innerType)
        assertElementText(innerType, "Int")
    }

    // MARK: - Protocol composition

    func test_parse_shouldParseComposition() {
        assertTypeText("A & B", "A & B")
    }

    func test_parse_shouldNotParseIncomplete() {
        assertTypeText("A &", "A")
    }

    func test_parse_shouldNotParseIncorrectComposition() {
        assertTypeText("A & 0", "A")
    }

    func test_parse_shouldNotParseIncorrectBinaryOperator() {
        assertTypeText("A | B", "A")
    }

    func test_parse_shouldParseMultipleComposition() {
        assertTypeText("A & B & C & D", "A & B & C & D")
    }

    func test_parse_shouldParseWhenFirstIsCorrectButNextIsWrong() {
        assertTypeText("A & B | C", "A & B")
        assertTypeText("A & B & 0", "A & B &")
    }

    func test_parse_shouldParseGenericTypes() {
        assertTypeText("A<T> & B<U>", "A<T> & B<U>")
    }

    func test_parse_shouldParseNestedTypes() {
        assertTypeText("A.B<T.U> & C.D<V.W>", "A.B<T.U> & C.D<V.W>")
    }

    func test_parse_shouldParseProtocolCompositionElement() {
        let composition = parse("A & B & C") as! ProtocolCompositionType
        XCTAssertEqual(composition.children.count, 3)
        XCTAssertEqual(composition.types.count, 3)
        XCTAssert(composition.children[0] === composition.types[0])
        assertElementText(composition.types[0], "A")
        XCTAssert(composition.children[1] === composition.types[1])
        assertElementText(composition.types[1], "B", offset: 4)
        XCTAssert(composition.children[2] === composition.types[2])
        assertElementText(composition.types[2], "C", offset: 8)
    }

    // MARK: - Keywords

    func test_parse_shouldParseAny() {
        assertTypeText("Any", "Any")
    }

    func test_parse_shouldParseSelf() {
        assertTypeText("Self", "Self")
    }

    // MARK: - Metatype

    func test_parse_shouldParseMetaTypes() {
        assertTypeText("MyType.Type", "MyType.Type")
        assertTypeText("MyType.Protocol", "MyType.Protocol")
    }

    // MARK: - Escaped

    func test_parse_shouldParseEscapedIdentifier() {
        assertTypeText("`Type`", "`Type`")
    }

    // MARK: - Tuple

    func test_parse_shouldParseEmptyImplicitArgumentTuple() {
        assertTypeText("()", "()")
    }

    func test_parse_shouldParseSingleBracketedType() {
        assertTypeText("(Type)", "(Type)")
        assertTypeText("(Generic<Type>.Nested)", "(Generic<Type>.Nested)")
        assertTypeText("([Int])", "([Int])")
        assertTypeText("([Int:String])", "([Int:String])")
    }

    func test_parse_shouldParseMultipleTypeImplicitArgumentTuple() {
        assertTypeText("(TypeA, TypeB)", "(TypeA, TypeB)")
        assertTypeText("(Generic<Type>.Nested, Nested.Type)", "(Generic<Type>.Nested, Nested.Type)")
        assertTypeText("([Int], [String:Int])", "([Int], [String:Int])")
    }

    func test_parse_shouldParseOptionalImplicitArgumentTuple() {
        assertTypeText("()?", "()?")
        assertTypeText("(TypeA)?", "(TypeA)?")
        assertTypeText("(TypeA, TypeB)?", "(TypeA, TypeB)?")
        assertTypeText("(Generic<Type>.Nested?, Nested.Type?)?", "(Generic<Type>.Nested?, Nested.Type?)?")
        assertTypeText("([Int?], [String?:Int?]?)?", "([Int?], [String?:Int?]?)?")
    }

    func test_parse_shouldParseExplicitArgumentTuple() {
        assertTypeText("(a: A)", "(a: A)")
        assertTypeText("(a: A, b: B)", "(a: A, b: B)")
        assertTypeText("(a: [Int?]!, b: B.C<D>?)", "(a: [Int?]!, b: B.C<D>?)")
    }

    func test_parse_shouldParseMixedExplicitAndImplicitArgumentTuple() {
        assertTypeText("(a: A, B)", "(a: A, B)")
        assertTypeText("(A, b: B)", "(A, b: B)")
    }

    func test_parse_shouldParseTupleWithAttributes() {
        assertTypeText("(a: @objc(a) @another A, @a B)", "(a: @objc(a) @another A, @a B)")
    }

    func test_parse_shouldParseTupleWithInout() {
        assertTypeText("(a: inout A, inout B)", "(a: inout A, inout B)")
    }

    func test_parse_shouldParseTupleWithInoutAndAttributes() {
        assertTypeText("(a: @a @b inout A, @c inout B)", "(a: @a @b inout A, @c inout B)")
    }

    // MARK: - Function type

    func test_parse_shouldParseEmptyFunction() {
        assertTypeText("() -> ()", "() -> ()")
    }

    func test_parse_shouldParseFunctionWithReturnType() {
        assertTypeText("() -> Void", "() -> Void")
        assertTypeText("() -> String", "() -> String")
    }

    func test_parse_shouldParseFunctionWithWildcardArgument() {
        assertTypeText("(_ a: A) -> ()", "(_ a: A) -> ()")
    }

    func test_parse_shouldParseFunctionWithMissingReturnType() {
        assertTypeText("() -> ", "() ->")
    }

    func test_parse_shouldParseThrowingFunction() {
        assertTypeText("() throws -> ()", "() throws -> ()")
    }

    func test_parse_shouldParseRethrowingFunction() {
        assertTypeText("() rethrows -> ()", "() rethrows -> ()")
    }

    func test_parse_shouldParseComplexFunction() {
        assertTypeText("@escaping @autoclosure (_ gen: @a inout Generic.Type<Inner>?, opt: Int?, @a inout T) rethrows -> [(String, returnType: Int):Int]", "@escaping @autoclosure (_ gen: @a inout Generic.Type<Inner>?, opt: Int?, @a inout T) rethrows -> [(String, returnType: Int):Int]")
    }

    // MARK: - Helpers

    func assertTypeText(_ input: String, _ expected: String, line: UInt = #line) {
        let element = parse(input)
        assertElementText(element, expected, line: line)
    }

    func assertErrorType(_ input: String, line: UInt = #line) {
        let element = parse(input)
        XCTAssertEqual(element.offset, -1)
    }

    func assertOffsetLength(_ input: String, _ expectedOffset: Int64, _ expectedLength: Int64, line: UInt = #line) {
        let element = parse(input)
        XCTAssertEqual(element.offset, expectedOffset, line: line)
        XCTAssertEqual(element.length, expectedLength, line: line)
    }

    func parse(_ text: String) -> SwiftType {
        return createParser(text, TypeParser.self).parse() as! SwiftType
    }
}
