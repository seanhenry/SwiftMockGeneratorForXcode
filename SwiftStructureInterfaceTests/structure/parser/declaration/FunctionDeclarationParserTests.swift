import XCTest
@testable import SwiftStructureInterface

// TODO: Parse code block
// TODO: Support operator name

class FunctionDeclarationParserTests: XCTestCase {

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
        var param = function.parameters[0] as! SwiftParameter
        XCTAssertEqual(param.text, "a: A")
        XCTAssertEqual(param.externalParameterName, nil)
        XCTAssertEqual(param.localParameterName, "a")
        XCTAssertEqual(param.offset, 7)
        XCTAssertEqual(param.length, 4)
        param = function.parameters[1] as! SwiftParameter
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
        XCTAssertFalse(function.throws)
    }

    func test_parse_shouldParseFuncWithDeclarationModifiers() {
        let function = parse("@a @objc(NS) public override mutating func a()")
        XCTAssertEqual(function.text, "@a @objc(NS) public override mutating func a()")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 46)
    }

    func test_parse_shouldParseFuncWithWhereClause() {
        let function = parse("func a() where T: Type")
        XCTAssertEqual(function.text, "func a() where T: Type")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 22)
    }

    func test_parse_shouldParseFuncWithWhereClauseAndReturnStatement() {
        let function = parse("func a() -> A where T: Type")
        XCTAssertEqual(function.text, "func a() -> A where T: Type")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 27)
    }

    func test_parse_shouldParseFuncWithGenericParameterClause() {
        let function = parse("func a<T, U: A & B>()")
        XCTAssertEqual(function.text, "func a<T, U: A & B>()")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 21)
        XCTAssertEqual(function.genericParameterClause?.text , "<T, U: A & B>")
        XCTAssertEqual(function.genericParameterClause?.offset , 6)
        XCTAssertEqual(function.genericParameterClause?.length , 13)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> FunctionDeclaration {
        let parser = createDeclarationParser(text, .func, FunctionDeclarationParser.self)
        return parser.parse()
    }
}
