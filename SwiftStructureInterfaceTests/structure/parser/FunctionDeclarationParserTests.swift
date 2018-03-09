import XCTest
@testable import SwiftStructureInterface

// TODO: Parse code block

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

    // MARK: - Helpers

    func parse(_ text: String) -> SwiftMethodElement {
        let parser = createDeclarationParser(text, .func, FunctionDeclarationParser.self)
        return parser.parse() as! SwiftMethodElement
    }
}
