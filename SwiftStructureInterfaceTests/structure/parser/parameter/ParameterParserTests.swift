import XCTest
@testable import SwiftStructureInterface

class ParameterParserTests: XCTestCase {

    var parser: Parser<Parameter>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldReturnErrorForEmptyMethodParameter() {
        XCTAssertThrowsError(try parse(""))
    }

    func test_parse_shouldReturnMinimumParameter() throws {
        let text = "a: A"
        let parameter = try parse(text)
        assertElementText(parameter, text)
        XCTAssertNil(parameter.externalParameterName)
        XCTAssertEqual(parameter.localParameterName, "a")
    }

    func test_parse_shouldReturnParameterWithExternalName() throws {
        let text = "ex a: A"
        let parameter = try parse(text)
        assertElementText(parameter, text)
        XCTAssertEqual(parameter.externalParameterName, "ex")
        XCTAssertEqual(parameter.localParameterName, "a")
    }

    func test_parse_shouldReturnParameterWithWildcard() throws {
        let text = "_ a: A"
        let parameter = try parse(text)
        assertElementText(parameter, text)
        XCTAssertEqual(parameter.externalParameterName, "_")
        XCTAssertEqual(parameter.localParameterName, "a")
    }

    func test_parse_shouldReturnParameterWithComplicatedType() throws {
        let text = "_ a: Generic<[Int]>.Nested?"
        let parameter = try parse(text)
        assertElementText(parameter, text)
        XCTAssertEqual(parameter.externalParameterName, "_")
        XCTAssertEqual(parameter.localParameterName, "a")
        let type: Element = parameter.typeAnnotation.type
        assertElementText(type, "Generic<[Int]>.Nested?", offset: 5)
    }

    func test_parse_shouldReturnParseParameterWithNoParameterName() throws {
        let text = ": A"
        let parameter = try parse(text)
        assertElementText(parameter, text)
    }

    func test_parse_shouldReturnParameterWithTypeAnnotation() throws {
        let text = "a: @a @b(c) inout A"
        let parameter = try parse(text)
        assertElementText(parameter, text)
        XCTAssertNil(parameter.externalParameterName)
        XCTAssertEqual(parameter.localParameterName, "a")
        let type: Element = parameter.typeAnnotation.type
        assertElementText(type, "A", offset: 18)
    }

    func test_parse_shouldReturnParameterWithVarArgs() throws {
        let text = "a: A..."
        let parameter = try parse(text)
        assertElementText(parameter, text)
        XCTAssertNil(parameter.externalParameterName)
        XCTAssertEqual(parameter.localParameterName, "a")
        let type: Element = parameter.typeAnnotation.type
        assertElementText(type, "A", offset: 3)
    }

    func test_parse_shouldEscapeKeywords() throws {
        let keywords = ["inout", "var", "let"]
        try keywords.forEach { keyword in
            let text = "`\(keyword)`: A"
            let parameter = try parse(text)
            assertElementText(parameter, text)
            XCTAssertNil(parameter.externalParameterName)
            XCTAssertEqual(parameter.localParameterName, "`\(keyword)`")
        }
    }

    func test_parse_shouldAllowBooleanIdentifiers() throws {
        let keywords = ["false", "true"]
        try keywords.forEach { keyword in
            let text = "\(keyword): A"
            let parameter = try parse(text)
            assertElementText(parameter, text)
            XCTAssertNil(parameter.externalParameterName)
            XCTAssertEqual(parameter.localParameterName, "\(keyword)")
        }
    }

    func test_parse_shouldAllowKeywordsAsIdentifiers() throws {
        let keywords = Keywords.keywords.keys
        try keywords.forEach { keyword in
            let text = "\(keyword): A"
            let parameter = try parse(text)
            assertElementText(parameter, text)
            XCTAssertNil(parameter.externalParameterName)
            XCTAssertEqual(parameter.localParameterName, "\(keyword)")
        }
    }

    func test_parse_shouldReturnParameterWithWhitespace() throws {
        let text = "_ a : @a inout A"
        let parameter = try parse(text)
        assertElementText(parameter, text)
    }

    func test_parse_shouldReturnParameterWithMinimalWhitespace() throws {
        let text = "_ a:A"
        let parameter = try parse(text)
        assertElementText(parameter, text)
    }

    func test_parse_shouldParseDefaultArgument() throws {
        let text = "a: MyClass = .defaultImpl()"
        let parameter = try parse(text)
        assertElementText(parameter, text)
        assertElementText(parameter.defaultArgumentClause, "= .defaultImpl()")
    }

    // MARK: - Helpers

    func parse(_ string: String) throws -> Parameter {
        let parser = createParser(string, ParameterParser.self)
        return try parser.parse()
    }
}
