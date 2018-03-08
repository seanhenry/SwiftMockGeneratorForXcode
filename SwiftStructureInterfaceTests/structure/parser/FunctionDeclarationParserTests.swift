import XCTest
@testable import SwiftStructureInterface

class FunctionDeclarationParserTests: XCTestCase {

    var parser: Parser<SwiftMethodElement>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseFuncWithEmptyParameterClause() {
        let parser = createDeclarationParser("func a()", .func, FunctionDeclarationParser.self)
        let function = parser.parse()
        XCTAssertEqual(function.text, "func a()")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 8)
    }

    func test_parse_shouldParseFuncWithSingleParameter() {
        let parser = createDeclarationParser("func a(a: A)", .func, FunctionDeclarationParser.self)
        let function = parser.parse()
        XCTAssertEqual(function.text, "func a(a: A)")
        XCTAssertEqual(function.name, "a")
        XCTAssertEqual(function.offset, 0)
        XCTAssertEqual(function.length, 12)
    }
}
