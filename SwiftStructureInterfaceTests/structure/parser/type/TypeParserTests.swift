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
        let text = "Swift.Type"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.typeName, "Type")
        XCTAssertEqual(type?.parentType?.text, "Swift")
        XCTAssertEqual(type?.parentType?.typeName, "Swift")
    }

    func test_parse_shouldParseDeeplyNestedType() {
        let text = "Swift.Deep.Nested.Type"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.typeName, "Type")
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
        let text = "Swift<A>.Type<B>"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.typeName, "Type")
        XCTAssertEqual(type?.genericArguments[0].text, "B")
        let parent = type?.parentType
        XCTAssertEqual(parent?.text, "Swift<A>")
        XCTAssertEqual(parent?.typeName, "Swift")
        XCTAssertEqual(parent?.genericArguments[0].text, "A")
    }

    func test_parse_shouldParseTypeCompositionElement() {
        let text = "Swift.Type"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.children.count, 1)
        XCTAssertEqual(type?.genericArguments.count, 0)
        let parent = type?.parentType
        XCTAssert(type?.children.first === parent)
        assertElementText(parent, "Swift", offset: 0)
    }

    // MARK: - Generic

    func test_parse_shouldParseGenericType() {
        assertTypeText("Generic<Type>", "Generic<Type>")
    }

    func test_parse_shouldNotParseNonGenericOperator() {
        assertTypeText("Generic|Type>", "Generic")
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
        XCTAssertEqual(type?.children.count, 1)
        XCTAssertEqual(type?.genericArguments.count, 1)
        XCTAssertEqual(type?.typeName, "Generic")
        let element = type?.genericArguments.first
        XCTAssert(type?.children.last === element)
        assertElementText(element, "Type", offset: 8)
    }

    func test_parse_shouldParseOptionalGenericElement() {
        let text = "Generic<Type>?"
        let type = parse(text) as? OptionalType
        let genericType = type?.type as? TypeIdentifier
        assertElementText(genericType, "Generic<Type>")
        XCTAssertEqual(genericType?.children.count, 1)
        XCTAssertEqual(genericType?.genericArguments.count, 1)
        XCTAssertEqual(genericType?.typeName, "Generic")
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
        XCTAssertEqual(type?.typeName, "H")
        var generic = type?.genericArguments.first
        XCTAssert(type?.children.last === generic)
        assertElementText(generic, "U", offset: 7)
        let parentType = type?.parentType
        XCTAssert(type?.children.first === parentType)
        assertElementText(parentType, "G<T>", offset: 0)
        XCTAssertEqual(parentType?.typeName, "G")
        generic = parentType?.genericArguments.first
        XCTAssert(parentType?.children.last === generic)
        assertElementText(generic, "T", offset: 2)
    }

    func test_parse_shouldParseDeepNestedGeneric() {
        let text = "G<T>.H<U>.I<V>"
        let type = parse(text) as? TypeIdentifier
        assertElementText(type, text)
        XCTAssertEqual(type?.children.count, 2)
        XCTAssertEqual(type?.genericArguments.count, 1)
        XCTAssertEqual(type?.typeName, "I")
        var generic = type?.genericArguments.first
        XCTAssert(type?.children.last === generic)
        assertElementText(generic, "V", offset: 12)
        var parentType = type?.parentType
        XCTAssert(type?.children.first === parentType)
        assertElementText(parentType, "G<T>.H<U>", offset: 0)
        XCTAssertEqual(parentType?.typeName, "H")
        generic = parentType?.genericArguments.first
        XCTAssert(parentType?.children.last === generic)
        assertElementText(generic, "U", offset: 7)
        parentType = parentType?.parentType
        assertElementText(parentType, "G<T>", offset: 0)
        XCTAssertEqual(parentType?.typeName, "G")
        generic = parentType?.genericArguments.first
        XCTAssert(parentType?.children.last === generic)
        assertElementText(generic, "T", offset: 2)
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

    func test_parse_shouldParseEmptyTuple() {
        let type = parse("()") as! TupleType
        XCTAssert(type.elements.isEmpty)
        XCTAssertEqual(type.text, "()")
        XCTAssertEqual(type.offset, 0)
        XCTAssertEqual(type.length, 2)
    }

    func test_parse_shouldParseSingleBracketedType() {
        let type = parse("(Type)") as! TupleType
        XCTAssertEqual(type.elements.count, 1)
        XCTAssertNil(type.elements[0].label)
        XCTAssert(type.elements[0].typeAnnotation.attributes.isEmpty)
        XCTAssertFalse(type.elements[0].typeAnnotation.isInout)
        XCTAssertEqual(type.elements[0].typeAnnotation.type.text, "Type")
        XCTAssertEqual(type.elements[0].typeAnnotation.text, "Type")
        XCTAssertEqual(type.elements[0].typeAnnotation.offset, 1)
        XCTAssertEqual(type.elements[0].typeAnnotation.length, 4)
    }

    func test_parse_shouldParseSingleBracketedTypeWithAttributes() {
        let type = parse("(@a @b inout Type)") as! TupleType
        XCTAssertEqual(type.elements.count, 1)
        XCTAssertNil(type.elements[0].label)
        XCTAssertEqual(type.elements[0].typeAnnotation.attributes, ["@a", "@b"])
        XCTAssert(type.elements[0].typeAnnotation.isInout)
    }

    func test_parse_shouldParseMultipleArgumentsTuple() {
        let type = parse("(TypeA, [String:Int])") as! TupleType
        XCTAssertEqual(type.elements.count, 2)
        XCTAssertEqual(type.elements[0].text, "TypeA")
        XCTAssertEqual(type.elements[0].offset, 1)
        XCTAssertEqual(type.elements[1].text, "[String:Int]")
        XCTAssertEqual(type.elements[1].offset, 8)
    }

    func test_parse_shouldParseOptionalEmptyTuple() {
        let type = parse("()?") as! OptionalType
        let tuple = type.type as! TupleType
        XCTAssertEqual(type.text, "()?")
        XCTAssertEqual(tuple.elements.count, 0)
        XCTAssertEqual(tuple.text, "()")
    }

    func test_parse_shouldParseOptionalTuple() {
        let type = parse("(TypeA, [Int])?") as! OptionalType
        let tuple = type.type as! TupleType
        XCTAssertEqual(type.text, "(TypeA, [Int])?")
        XCTAssertEqual(tuple.text, "(TypeA, [Int])")
        XCTAssertEqual(tuple.elements.count, 2)
        XCTAssertEqual(tuple.elements[0].text, "TypeA")
        XCTAssertEqual(tuple.elements[0].offset, 1)
        XCTAssertEqual(tuple.elements[1].text, "[Int]")
        XCTAssertEqual(tuple.elements[1].offset, 8)
    }

    func test_parse_shouldParseExplicitArgumentTuple() {
        let type = parse("(a: A, b, c: C.C<C>?)") as! TupleType
        XCTAssertEqual(type.elements[0].label, "a")
        XCTAssertNil(type.elements[1].label)
        XCTAssertEqual(type.elements[2].label, "c")
    }

    func test_parse_shouldIgnoreWildcardArgumentsInTuple() {
        let type = parse("(_: A, _ b: B)") as! TupleType
        XCTAssertNil(type.elements[0].label)
        XCTAssertEqual(type.elements[1].label, "b")
        XCTAssertEqual(type.text, "(_: A, _ b: B)")
    }

    func test_parse_shouldAddTupleTypesToTupleChildren() {
        let type = parse("(a: A, b: B)") as! TupleType
        XCTAssert(type.children[0] === type.elements[0])
        XCTAssert(type.children[1] === type.elements[1])
        XCTAssert(type.elements[0].children[0] === type.elements[0].typeAnnotation)
    }

    // MARK: - Function type

    func test_parse_shouldParseEmptyFunction() {
        let type = parse("() -> ()") as! FunctionType
        XCTAssert(type.attributes.isEmpty)
        XCTAssertEqual(type.arguments.text, "()")
        XCTAssertEqual(type.returnType.text, "()")
        XCTAssertFalse(type.throws)
        XCTAssertFalse(type.rethrows)
        XCTAssertEqual(type.offset, 0)
        XCTAssertEqual(type.length, 8)
        XCTAssertEqual(type.text, "() -> ()")
    }

    func test_parse_shouldParseFunctionWithReturnType() {
        let type = parse("() -> String") as! FunctionType
        XCTAssertEqual(type.returnType.text, "String")
        XCTAssertEqual(type.returnType.offset, 6)
        XCTAssertEqual(type.returnType.length, 6)
    }

    func test_parse_shouldParseFunctionWithArgument() {
        let type = parse("(A) -> ()") as! FunctionType
        XCTAssertEqual(type.arguments.text, "(A)")
    }

    func test_parse_shouldParseFunctionWithWildcardArgument() {
        let type = parse("(_ a: A) -> ()") as! FunctionType
        XCTAssertEqual(type.arguments.text, "(_ a: A)")
    }

    func test_parse_shouldParseFunctionWithMissingReturnType() {
        XCTAssertNotNil(parse("() -> ") as? FunctionType)
    }

    func test_parse_shouldParseThrowingFunction() {
        let type = parse("() throws -> ()") as! FunctionType
        XCTAssert(type.throws)
    }

    func test_parse_shouldParseRethrowingFunction() {
        let type = parse("() rethrows -> ()") as! FunctionType
        XCTAssert(type.rethrows)
    }

    func test_parse_shouldParseAttributes() {
        let type = parse("@escaping @b () -> ()") as! FunctionType
        XCTAssertEqual(type.attributes[0], "@escaping")
        XCTAssertEqual(type.attributes[1], "@b")
    }

    func test_parse_shouldParseComplexFunction() {
        let text = "@escaping @autoclosure (_ gen: @a inout Generic.Type<Inner>?, opt: Int?, @a inout T) rethrows -> [(String, returnType: Int):Int]"
        let type = parse(text)
        XCTAssert(type is FunctionType)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldSetFunctionChildren() {
        let type = parse("(A) -> B") as! FunctionType
        XCTAssert(type.children[0] === type.arguments)
        XCTAssert(type.children[1] === type.returnType)
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
