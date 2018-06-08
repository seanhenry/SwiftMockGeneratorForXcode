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
        XCTAssert(parameter === ParameterImpl.errorParameter)
    }

    func test_parse_shouldReturnMinimumParameter() {
        let text = "a: A"
        let parameter = parse(text)
        assertElementText(parameter, text)
        XCTAssertNil(parameter.externalParameterName)
        XCTAssertEqual(parameter.localParameterName, "a")
    }

    func test_parse_shouldReturnParameterWithExternalName() {
        let text = "ex a: A"
        let parameter = parse(text)
        assertElementText(parameter, text)
        XCTAssertEqual(parameter.externalParameterName, "ex")
        XCTAssertEqual(parameter.localParameterName, "a")
    }

    func test_parse_shouldReturnParameterWithWildcard() {
        let text = "_ a: A"
        let parameter = parse(text)
        assertElementText(parameter, text)
        XCTAssertEqual(parameter.externalParameterName, "_")
        XCTAssertEqual(parameter.localParameterName, "a")
    }

    func test_parse_shouldReturnParameterWithComplicatedType() {
        let text = "_ a: Generic<[Type]>.Nested?"
        let parameter = parse(text)
        assertElementText(parameter, text)
        XCTAssertEqual(parameter.externalParameterName, "_")
        XCTAssertEqual(parameter.localParameterName, "a")
        let type: Element = parameter.typeAnnotation.type
        assertElementText(type, "Generic<[Type]>.Nested?", offset: 5)
    }

    func test_parse_shouldReturnErrorParameterWithNoParameterName() {
        let parameter = parse(": A")
        XCTAssert(parameter === ParameterImpl.errorParameter)
    }

    func test_parse_shouldReturnParameterWithTypeAnnotation() {
        let text = "a: @a @b(c) inout A"
        let parameter = parse(text)
        assertElementText(parameter, text)
        XCTAssertNil(parameter.externalParameterName)
        XCTAssertEqual(parameter.localParameterName, "a")
        let type: Element = parameter.typeAnnotation.type
        assertElementText(type, "A", offset: 18)
    }

    func test_parse_shouldReturnParameterWithVarArgs() {
        let text = "a: A..."
        let parameter = parse(text)
        assertElementText(parameter, text)
        XCTAssertNil(parameter.externalParameterName)
        XCTAssertEqual(parameter.localParameterName, "a")
        let type: Element = parameter.typeAnnotation.type
        assertElementText(type, "A", offset: 3)
    }

    func test_parse_shouldEscapeKeywords() {
        let keywords = ["inout", "var", "let"]
        keywords.forEach { keyword in
            let text = "`\(keyword)`: A"
            let parameter = parse(text)
            assertElementText(parameter, text)
            XCTAssertNil(parameter.externalParameterName)
            XCTAssertEqual(parameter.localParameterName, "`\(keyword)`")
        }
    }

    func test_parse_shouldAllowBooleanIdentifiers() {
        let keywords = ["false", "true"]
        keywords.forEach { keyword in
            let text = "\(keyword): A"
            let parameter = parse(text)
            assertElementText(parameter, text)
            XCTAssertNil(parameter.externalParameterName)
            XCTAssertEqual(parameter.localParameterName, "\(keyword)")
        }
    }

    // MARK: - Helpers

    func parse(_ string: String) -> ParameterImpl {
        let parser = createParser(string, FunctionDeclarationParser.ParameterParser.self)
        return parser.parse() as! ParameterImpl
    }
}
