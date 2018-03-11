import XCTest
@testable import SwiftStructureInterface

// TODO: Support default argument clause

class FunctionDeclarationParameterParserTests: XCTestCase {

    var parser: Parser<Parameter>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldReturnErrorForEmptyMethodParameter() {
        let parameter = parse("")
        XCTAssert(parameter === SwiftParameter.errorMethodParameter)
    }

    func test_parse_shouldReturnMinimumParameter() {
        let parameter = parse("a: A")
        XCTAssertEqual(parameter.text, "a: A")
        XCTAssertNil(parameter.externalParameterName)
        XCTAssertEqual(parameter.localParameterName, "a")
        XCTAssertEqual(parameter.offset, 0)
        XCTAssertEqual(parameter.length, 4)
    }

    func test_parse_shouldReturnParameterWithExternalName() {
        let parameter = parse("ex a: A")
        XCTAssertEqual(parameter.text, "ex a: A")
        XCTAssertEqual(parameter.externalParameterName, "ex")
        XCTAssertEqual(parameter.localParameterName, "a")
        XCTAssertEqual(parameter.offset, 0)
        XCTAssertEqual(parameter.length, 7)
    }

    func test_parse_shouldReturnParameterWithWildcard() {
        let parameter = parse("_ a: A")
        XCTAssertEqual(parameter.text, "_ a: A")
        XCTAssertEqual(parameter.externalParameterName, "_")
        XCTAssertEqual(parameter.localParameterName, "a")
        XCTAssertEqual(parameter.offset, 0)
        XCTAssertEqual(parameter.length, 6)
    }

    func test_parse_shouldReturnParameterWithComplicatedType() {
        let parameter = parse("_ a: Generic<[Type]>.Nested?")
        XCTAssertEqual(parameter.text, "_ a: Generic<[Type]>.Nested?")
        XCTAssertEqual(parameter.externalParameterName, "_")
        XCTAssertEqual(parameter.localParameterName, "a")
        XCTAssertEqual(parameter.offset, 0)
        XCTAssertEqual(parameter.length, 28)
        let type: Element = parameter.type
        XCTAssertEqual(type.text, "Generic<[Type]>.Nested?")
        XCTAssertEqual(type.offset, 5)
        XCTAssertEqual(type.length, 23)
    }

    func test_parse_shouldReturnErrorParameterWithNoParameterName() {
        let parameter = parse(": A")
        XCTAssert(parameter === SwiftParameter.errorMethodParameter)
    }

    func test_parse_shouldReturnParameterWithTypeAnnotation() {
        let parameter = parse("a: @a @b(c) inout A")
        XCTAssertEqual(parameter.text, "a: @a @b(c) inout A")
        XCTAssertNil(parameter.externalParameterName)
        XCTAssertEqual(parameter.localParameterName, "a")
        XCTAssertEqual(parameter.offset, 0)
        XCTAssertEqual(parameter.length, 19)
        let type: Element = parameter.type
        XCTAssertEqual(type.text, "A")
        XCTAssertEqual(type.offset, 18)
        XCTAssertEqual(type.length, 1)
    }

    func test_parse_shouldReturnParameterWithVarArgs() {
        let parameter = parse("a: A...")
        XCTAssertEqual(parameter.text, "a: A...")
        XCTAssertNil(parameter.externalParameterName)
        XCTAssertEqual(parameter.localParameterName, "a")
        XCTAssertEqual(parameter.offset, 0)
        XCTAssertEqual(parameter.length, 7)
        let type: Element = parameter.type
        XCTAssertEqual(type.text, "A")
        XCTAssertEqual(type.offset, 3)
        XCTAssertEqual(type.length, 1)
    }

    // MARK: - Helpers

    func parse(_ string: String) -> SwiftParameter {
        let parser = createParser(string, FunctionDeclarationParser.ParameterParser.self)
        return parser.parse() as! SwiftParameter
    }
}
