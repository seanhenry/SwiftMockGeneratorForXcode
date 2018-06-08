import XCTest
@testable import SwiftStructureInterface

// TODO: Parse code block
// TODO: Support operator name

class FunctionDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseFuncWithEmptyParameterClause() {
        let text = "func a()"
        let function = parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        XCTAssertNil(function.returnType)
        XCTAssertFalse(function.throws)
    }

    func test_parse_shouldParseFuncWithParameters() {
        let text = "func a(a: A, _ b: B)"
        let function = parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        var param = function.parameters[0] as! ParameterImpl
        assertElementText(param, "a: A", offset: 7)
        XCTAssertEqual(param.externalParameterName, nil)
        XCTAssertEqual(param.localParameterName, "a")
        param = function.parameters[1] as! ParameterImpl
        assertElementText(param, "_ b: B", offset: 13)
        XCTAssertEqual(param.externalParameterName, "_")
        XCTAssertEqual(param.localParameterName, "b")
    }

    func test_parse_shouldParseFuncWithReturnType() {
        let text = "func a() -> Type"
        let function = parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        let type = function.returnType
        assertElementText(type, "Type", offset: 12)
    }

    func test_parse_shouldParseThrowingFunc() {
        let text = "func a() throws"
        let function = parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        XCTAssert(function.throws)
    }

    func test_parse_shouldParseRethrowingFunc() {
        let text = "func a() rethrows"
        let function = parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        XCTAssertFalse(function.throws)
    }

    func test_parse_shouldParseFuncWithDeclarationModifiers() {
        let text = "@a @objc(NS) public override mutating func a()"
        let function = parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
    }

    func test_parse_shouldParseFuncWithWhereClause() {
        let text = "func a() where T: Type"
        let function = parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
    }

    func test_parse_shouldParseFuncWithWhereClauseAndReturnStatement() {
        let text = "func a() -> A where T: Type"
        let function = parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
    }

    func test_parse_shouldParseFuncWithGenericParameterClause() {
        let text = "func a<T, U: A & B>()"
        let function = parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        assertElementText(function.genericParameterClause, "<T, U: A & B>", offset: 6)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> FunctionDeclaration {
        let parser = createDeclarationParser(text, .func, FunctionDeclarationParser.self)
        return parser.parse()
    }
}
