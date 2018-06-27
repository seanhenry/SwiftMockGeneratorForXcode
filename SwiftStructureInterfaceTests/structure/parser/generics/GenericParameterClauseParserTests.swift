import XCTest
@testable import SwiftStructureInterface

class GenericParameterClauseParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseSimpleClause() throws {
        let clause = try parse("<T>")
        XCTAssertEqual(clause.parameters.count, 1)
        XCTAssertEqual(clause.parameters[0].name, "T")
        XCTAssertEqual(clause.parameters[0].text, "T")
        XCTAssertNil(clause.parameters[0].protocolComposition)
        XCTAssertNil(clause.parameters[0].typeIdentifier)
    }

    func test_parse_shouldParseClauseWithTypeIdentifier() throws {
        let clause = try parse("<T:A>")
        XCTAssertEqual(clause.parameters.count, 1)
        XCTAssertEqual(clause.parameters[0].name, "T")
        XCTAssertEqual(clause.parameters[0].text, "T:A")
        XCTAssertNil(clause.parameters[0].protocolComposition)
        XCTAssertEqual(clause.parameters[0].typeIdentifier?.typeName, "A")
    }

    func test_parse_shouldParseArgumentWithProtocolComposition() throws {
        let clause = try parse("<T: A & B>")
        XCTAssertEqual(clause.parameters.count, 1)
        XCTAssertEqual(clause.parameters[0].name, "T")
        XCTAssertEqual(clause.parameters[0].text, "T: A & B")
        XCTAssertEqual(clause.parameters[0].protocolComposition?.text, "A & B")
        XCTAssertNil(clause.parameters[0].typeIdentifier?.typeName)
    }

    func test_parse_shouldParseManyParameterClause() throws {
        let clause = try parse("<T:A,U==B>")
        XCTAssertEqual(clause.text, "<T:A,U==B>")
        XCTAssertEqual(clause.parameters[0].name, "T")
        XCTAssertEqual(clause.parameters[0].text, "T:A")
        XCTAssertEqual(clause.parameters[0].typeIdentifier?.text, "A")
        XCTAssertEqual(clause.parameters[1].name, "U")
        XCTAssertEqual(clause.parameters[1].text, "U==B")
        XCTAssertEqual(clause.parameters[1].typeIdentifier?.text, "B")
    }

    func test_parse_shouldParseWhitespace() throws {
        let text = "< T : A , U == B & C , V >"
        let clause = try parse(text)
        XCTAssertEqual(clause.text, text)
    }

    func test_parse_shouldThrowWhenNotStartingWithLeftChevron() {
        XCTAssertThrowsError(try parse("T>"))
    }

    // MARK: - Helpers

    func assertText(_ input: String, _ expected: String, line: UInt = #line) {
        assertElementText(try! parse(input), input, line: line)
    }

    func parse(_ text: String) throws -> GenericParameterClause {
        let parser = createParser(text, GenericParameterClauseParser.self)
        return try parser.parse()
    }
}
