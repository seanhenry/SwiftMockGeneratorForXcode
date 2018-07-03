import XCTest
@testable import SwiftStructureInterface

class VariableDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseSimpleVariable() throws {
        let text = "var a: Int"
        let variable = try parse(text)
        XCTAssertEqual(variable.text, text)
        XCTAssertEqual(variable.name, "a")
        XCTAssertEqual(variable.typeAnnotation.text, ": Int")
    }

    func test_parse_shouldParseVariableWithoutName() throws {
        let text = "var : Int"
        let variable = try parse(text)
        XCTAssertEqual(variable.text, text)
        XCTAssertEqual(variable.name, "")
    }

    func test_parse_shouldParseVariableWithoutType() throws {
        let text = "var a"
        let variable = try parse(text)
        XCTAssertEqual(variable.text, text)
        XCTAssertEqual(variable.name, "a")
    }

    func test_parse_shouldParseVariableWithAttributesAndInout() throws {
        let text = "var a: @a inout Int"
        let variable = try parse(text)
        XCTAssertEqual(variable.text, text)
        XCTAssertEqual(variable.name, "a")
    }

    func test_parse_shouldParseVariableWithGetterSetter() throws {
        let text = "var a: @a inout Int { mutating set @a nonmutating get }"
        let variable = try parse(text)
        XCTAssertEqual(variable.text, text)
        XCTAssertEqual(variable.name, "a")
        XCTAssert(variable.isWritable)
    }

    func test_parse_shouldParseVariableWithGetter() throws {
        let text = "var a: @a inout Int { get }"
        let variable = try parse(text)
        XCTAssertEqual(variable.text, text)
        XCTAssertEqual(variable.name, "a")
        XCTAssertFalse(variable.isWritable)
    }

    func test_parse_shouldParseVariableWithAttributesAndModifiers() throws {
        let text = "@a public weak mutating var a: Int { get }"
        let variable = try parse(text)
        XCTAssertEqual(variable.text, text)
        XCTAssertEqual(variable.name, "a")
        XCTAssertFalse(variable.isWritable)
    }

    func test_parse_shouldParseVariableWithCodeBlock() throws {
        let text = "var a: Int { statement }"
        let variable = try parse(text)
        XCTAssertEqual(variable.text, text)
        XCTAssertEqual(variable.codeBlock?.text, "{ statement }")
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> VariableDeclaration {
        let parser = createDeclarationParser(text, .var, VariableDeclarationParser.self)
        return try parser.parse()
    }
}
