import XCTest
@testable import SwiftStructureInterface

class FunctionDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseFuncWithEmptyParameterClause() throws {
        let text = "func a()"
        let function = try parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        XCTAssertNil(function.returnType)
        XCTAssertFalse(function.throws)
    }

    func test_parse_shouldParseFuncWithParameters() throws {
        let text = "func a(a: A, _ b: B)"
        let function = try parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        var param = function.parameterClause.parameters[0]
        assertElementText(param, "a: A")
        XCTAssertEqual(param.externalParameterName, nil)
        XCTAssertEqual(param.localParameterName, "a")
        param = function.parameterClause.parameters[1]
        assertElementText(param, "_ b: B")
        XCTAssertEqual(param.externalParameterName, "_")
        XCTAssertEqual(param.localParameterName, "b")
    }

    func test_parse_shouldParseFuncWithReturnType() throws {
        let text = "func a() -> Int"
        let function = try parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        let result = function.returnType
        assertElementText(result, "-> Int")
        assertElementText(result?.type, "Int")
    }

    func test_parse_shouldParseThrowingFunc() throws {
        let text = "func a() throws"
        let function = try parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        XCTAssert(function.throws)
    }

    func test_parse_shouldParseRethrowingFunc() throws {
        let text = "func a() rethrows"
        let function = try parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        XCTAssertFalse(function.throws)
    }

    func test_parse_shouldParseFuncWithDeclarationModifiers() throws {
        let text = "@a @objc(NS) public override mutating func a()"
        let function = try parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
    }

    func test_parse_shouldParseFuncWithWhereClause() throws {
        let text = "func a() where T: U"
        let function = try parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
    }

    func test_parse_shouldParseFuncWithWhereClauseAndReturnStatement() throws {
        let text = "func a() -> A where T: U"
        let function = try parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
    }

    func test_parse_shouldParseFuncWithGenericParameterClause() throws {
        let text = "func a<T, U: A & B>()"
        let function = try parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "a")
        assertElementText(function.genericParameterClause, "<T, U: A & B>")
    }

    func test_parse_shouldParseFuncWithCodeBlock() throws {
        let text = "func a() { statement }"
        let function = try parse(text)
        assertElementText(function, text)
        assertElementText(function.codeBlock, "{ statement }")
    }

    func test_parse_shouldParseFuncWithKeywordIdentifier() throws {
        let text = "func final()"
        let function = try parse(text)
        assertElementText(function, text)
        XCTAssertEqual(function.name, "final")
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> FunctionDeclaration {
        let parser = createDeclarationParser(text, .func, FunctionDeclarationParser.self)
        return try parser.parse()
    }
}
