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

    func test_parse_shouldParseComplicatedGenericType() {
        assertTypeName("Nested.Generic<With.Nested.Generic<Inside.Another>, Side.By<Side, Again>>", "Nested.Generic<With.Nested.Generic<Inside.Another>, Side.By<Side, Again>>")
    }

    func test_parse_shouldCalculateLengthWhenDifferentFormatting() {
        assertOffsetLength("A < B,C > next element", 0, 9)
    }

    func test_parse_shouldParseGenericWithArrayType() {
        assertTypeName("Generic<[Int]>", "Generic<[Int]>")
    }

    func test_parse_shouldParseGenericWithDictionaryType() {
        assertTypeName("Generic<[Int:String]>", "Generic<[Int:String]>")
    }

    func test_parse_shouldParseNestedGeneric() {
        assertTypeName("Generic<Type>.Another<Generic>", "Generic<Type>.Another<Generic>")
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

    // MARK: - Dictionary

    func test_parse_shouldParseDictionary() {
        assertTypeName("[A:B]", "[A:B]")
    }

    func test_parse_shouldParseDictionaryWithNestedTypes() {
        assertTypeName("[A.B.C:D.E.F]", "[A.B.C:D.E.F]")
    }

    func test_parse_shouldParseDictionaryWithGenericTypes() {
        assertTypeName("[Generic<Type>:Generic<Type>]", "[Generic<Type>:Generic<Type>]")
    }

    func test_parse_shouldParseDictionaryWithArray() {
        assertTypeName("[[Int]:[String]]", "[[Int]:[String]]")
    }

    // MARK: - Optional

    func test_parse_shouldParseOptional() {
        assertTypeName("Int?", "Int?")
    }

    func test_parse_shouldParseNestedTypeOptional() {
        assertTypeName("A.B.C?", "A.B.C?")
    }

    func test_parse_shouldParseGenericOptional() {
        assertTypeName("Generic<Type>?", "Generic<Type>?")
    }

    func test_parse_shouldParseOptionalArray() {
        assertTypeName("[Int?]?", "[Int?]?")
    }

    func test_parse_shouldParseOptionalDictionary() {
        assertTypeName("[[String?:Int?]?:Int?]?", "[[String?:Int?]?:Int?]?")
    }

    func test_parse_shouldDoubleOptional() {
        assertTypeName("Int??", "Int??")
    }

    // MARK: - IUO

    func test_parse_shouldParseIUO() {
        assertTypeName("Int!", "Int!")
    }

    func test_parse_shouldParseNestedTypeIUO() {
        assertTypeName("A.B.C!", "A.B.C!")
    }

    func test_parse_shouldParseGenericIUO() {
        assertTypeName("Generic<Type>!", "Generic<Type>!")
    }

    func test_parse_shouldParseIUOArray() {
        assertTypeName("[Int!]!", "[Int!]!")
    }

    func test_parse_shouldParseIUODictionary() {
        assertTypeName("[[String!:Int!]!:Int!]!", "[[String!:Int!]!:Int!]!")
    }

    func test_parse_shouldDoubleIUO() {
        assertTypeName("Int!!", "Int!!")
    }

    // MARK: - Protocol composition

    func test_parse_shouldParseComposition() {
        assertTypeName("A & B", "A & B")
    }

    func test_parse_shouldNotParseIncomplete() {
        assertTypeName("A &", "A")
    }

    func test_parse_shouldNotParseIncorrectComposition() {
        assertTypeName("A & 0", "A")
    }

    func test_parse_shouldNotParseIncorrectBinaryOperator() {
        assertTypeName("A | B", "A")
    }

    func test_parse_shouldParseMultipleComposition() {
        assertTypeName("A & B & C & D", "A & B & C & D")
    }

    func test_parse_shouldParseWhenFirstIsCorrectButNextIsWrong() {
        assertTypeName("A & B | C", "A & B")
        assertTypeName("A & B & 0", "A & B & ")
    }

    func test_parse_shouldParseGenericTypes() {
        assertTypeName("A<T> & B<U>", "A<T> & B<U>")
    }

    func test_parse_shouldParseNestedTypes() {
        assertTypeName("A.B<T.U> & C.D<V.W>", "A.B<T.U> & C.D<V.W>")
    }

    // MARK: - Keywords

    func test_parse_shouldParseAny() {
        assertTypeName("Any", "Any")
    }

    func test_parse_shouldParseSelf() {
        assertTypeName("Self", "Self")
    }

    // MARK: - Metatype

    func test_parse_shouldParseMetaTypes() {
        assertTypeName("MyType.Type", "MyType.Type")
        assertTypeName("MyType.Protocol", "MyType.Protocol")
    }

    // MARK: - Implicit

    func test_parse_shouldParseImplicitType() {
        assertTypeName("$0", "$0")
        assertTypeName("$10", "$10")
    }

    func test_parse_shouldAssumeZeroWhenIncompleteImplicitType() {
        assertTypeName("$", "$0")
        assertTypeName("$a", "$0")
    }

    // MARK: - Tuple

    func test_parse_shouldParseEmptyImplicitArgumentTuple() {
        assertTypeName("()", "()")
    }

    func test_parse_shouldParseSingleBracketedType() {
        assertTypeName("(Type)", "(Type)")
        assertTypeName("(Generic<Type>.Nested)", "(Generic<Type>.Nested)")
        assertTypeName("([Int])", "([Int])")
        assertTypeName("([Int:String])", "([Int:String])")
    }

    func test_parse_shouldParseMultipleTypeImplicitArgumentTuple() {
        assertTypeName("(TypeA, TypeB)", "(TypeA, TypeB)")
        assertTypeName("(Generic<Type>.Nested, Nested.Type)", "(Generic<Type>.Nested, Nested.Type)")
        assertTypeName("([Int], [String:Int])", "([Int], [String:Int])")
    }

    func test_parse_shouldParseOptionalImplicitArgumentTuple() {
        assertTypeName("()?", "()?")
        assertTypeName("(TypeA)?", "(TypeA)?")
        assertTypeName("(TypeA, TypeB)?", "(TypeA, TypeB)?")
        assertTypeName("(Generic<Type>.Nested?, Nested.Type?)?", "(Generic<Type>.Nested?, Nested.Type?)?")
        assertTypeName("([Int?], [String?:Int?]?)?", "([Int?], [String?:Int?]?)?")
    }

    func test_parse_shouldParseExplicitArgumentTuple() {
        assertTypeName("(a: A)", "(a: A)")
        assertTypeName("(a: A, b: B)", "(a: A, b: B)")
        assertTypeName("(a: [Int?]!, b: B.C<D>?)", "(a: [Int?]!, b: B.C<D>?)")
    }

    func test_parse_shouldParseMixedExplicitAndImplicitArgumentTuple() {
        assertTypeName("(a: A, B)", "(a: A, B)")
        assertTypeName("(A, b: B)", "(A, b: B)")
    }

    func test_parse_shouldParseTupleWithAttributes() {
        assertTypeName("(a: @objc(a) @another A, @a B)", "(a: @objc(a) @another A, @a B)")
    }

    func test_parse_shouldParseTupleWithInout() {
        assertTypeName("(a: inout A, inout B)", "(a: inout A, inout B)")
    }

    func test_parse_shouldParseTupleWithInoutAndAttributes() {
        assertTypeName("(a: @a @b inout A, @c inout B)", "(a: @a @b inout A, @c inout B)")
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
