import XCTest
@testable import SwiftStructureInterface

class GenericParameterClauseParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseSimpleClause() {
        let clause = parse("<T>")
        XCTAssertEqual(clause.parameters.count, 1)
        XCTAssertEqual(clause.parameters[0].typeName, "T")
        XCTAssertEqual(clause.parameters[0].text, "T")
        XCTAssertNil(clause.parameters[0].protocolComposition)
        XCTAssertNil(clause.parameters[0].typeIdentifier)
    }

    func test_parse_shouldParseClauseWithTypeIdentifier() {
        let clause = parse("<T:A>")
        XCTAssertEqual(clause.parameters.count, 1)
        XCTAssertEqual(clause.parameters[0].typeName, "T")
        XCTAssertEqual(clause.parameters[0].text, "T:A")
        XCTAssertNil(clause.parameters[0].protocolComposition)
        XCTAssertEqual(clause.parameters[0].typeIdentifier?.typeName, "A")
    }

    func test_parse_shouldParseArgumentWithProtocolComposition() {
        let clause = parse("<T: A & B>")
        XCTAssertEqual(clause.parameters.count, 1)
        XCTAssertEqual(clause.parameters[0].typeName, "T")
        XCTAssertEqual(clause.parameters[0].text, "T: A & B")
        XCTAssertEqual(clause.parameters[0].protocolComposition?.text, "A & B")
        XCTAssertNil(clause.parameters[0].typeIdentifier?.typeName)
    }

    func test_parse_shouldParseWhitespace() {
        let clause = parse("< T : A >")
        XCTAssertEqual(clause.text, "< T : A >")
        XCTAssertEqual(clause.parameters[0].typeName, "T")
        XCTAssertEqual(clause.parameters[0].text, "T : A")
        XCTAssertEqual(clause.parameters[0].typeIdentifier?.text, "A")
    }

    func test_parse_shouldReturnEmptyClause() {
        let clause = parse("")
        XCTAssert(clause === GenericParameterClauseImpl.emptyGenericParameterClause)
    }

    // MARK: - Helpers

    func assertText(_ input: String, _ expected: String, line: UInt = #line) {
        assertElementText(parse(input), input, line: line)
    }

    func parse(_ text: String) -> GenericParameterClause {
        let parser = createParser(text, GenericParameterClauseParser.self)
        return parser.parse()
    }
}
