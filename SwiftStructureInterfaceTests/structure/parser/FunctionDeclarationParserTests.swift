import XCTest
@testable import SwiftStructureInterface

// TODO: Parse code block
// TODO: Support operator name

class FunctionDeclarationParserTests: XCTestCase {

    var parser: Parser<NamedElement>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseFuncWithEmptyParameterClause() {
        let function = parse("func a()")
        XCTAssertEqual(function.text, "func a()")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 8)
        XCTAssertNil(function.returnType)
        XCTAssertFalse(function.throws)
    }

    func test_parse_shouldParseFuncWithParameters() {
        let function = parse("func a(a: A, _ b: B)")
        XCTAssertEqual(function.text, "func a(a: A, _ b: B)")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 20)
        var param = function.parameters[0] as! SwiftMethodParameter
        XCTAssertEqual(param.text, "a: A")
        XCTAssertEqual(param.externalParameterName, nil)
        XCTAssertEqual(param.localParameterName, "a")
        XCTAssertEqual(param.offset, 7)
        XCTAssertEqual(param.length, 4)
        param = function.parameters[1] as! SwiftMethodParameter
        XCTAssertEqual(param.text, "_ b: B")
        XCTAssertEqual(param.externalParameterName, "_")
        XCTAssertEqual(param.localParameterName, "b")
        XCTAssertEqual(param.offset, 13)
        XCTAssertEqual(param.length, 6)
    }

    func test_parse_shouldParseFuncWithReturnType() {
        let function = parse("func a() -> Type")
        XCTAssertEqual(function.text, "func a() -> Type")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 16)
        let type = function.returnType
        XCTAssertEqual(type?.text, "Type")
        XCTAssertEqual(type?.offset, 12)
        XCTAssertEqual(type?.length, 4)
    }

    func test_parse_shouldParseThrowingFunc() {
        let function = parse("func a() throws")
        XCTAssertEqual(function.text, "func a() throws")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 15)
        XCTAssert(function.throws)
    }

    func test_parse_shouldParseRethrowingFunc() {
        let function = parse("func a() rethrows")
        XCTAssertEqual(function.text, "func a() rethrows")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 17)
        XCTAssert(function.throws)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> SwiftMethodElement {
        let parser = createDeclarationParser(text, .func, FunctionDeclarationParser.self)
        return parser.parse() as! SwiftMethodElement
    }
}
