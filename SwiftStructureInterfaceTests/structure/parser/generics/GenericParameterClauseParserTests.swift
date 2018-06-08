import XCTest
@testable import SwiftStructureInterface

class GenericParameterClauseParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseSimpleClause() {
        let clause = parse("<T>")
        XCTAssertEqual(clause.parameters.count, 1)
        XCTAssertEqual(clause.parameters[0].typeName, "T")
        XCTAssertNil(clause.parameters[0].protocolComposition)
        XCTAssertNil(clause.parameters[0].typeIdentifier)
    }

    func test_parse_shouldParseClauseWithTypeIdentifier() {
        let clause = parse("<T: A>")
        XCTAssertEqual(clause.parameters.count, 1)
        XCTAssertEqual(clause.parameters[0].typeName, "T")
        XCTAssertNil(clause.parameters[0].protocolComposition)
        XCTAssertEqual(clause.parameters[0].typeIdentifier?.typeName, "A")
    }

    func test_parse_shouldParseArgumentWithProtocolComposition() {
        let clause = parse("<T: A & B>")
        XCTAssertEqual(clause.parameters.count, 1)
        XCTAssertEqual(clause.parameters[0].typeName, "T")
        XCTAssertEqual(clause.parameters[0].protocolComposition?.text, "A & B")
        XCTAssertNil(clause.parameters[0].typeIdentifier?.typeName)
    }

    func test_parse_shouldAddChildrenToParameter() {
        let clause = parse("<T, U: A, V: A & B>")
        XCTAssert(clause.children[0] === clause.parameters[0])
        XCTAssert(clause.children[1] === clause.parameters[1])
        XCTAssert(clause.parameters[0].children.isEmpty)
        XCTAssert(clause.parameters[1].children[0] === clause.parameters[1].typeIdentifier)
        XCTAssert(clause.parameters[2].children[0] === clause.parameters[2].protocolComposition)
    }

    func test_parse_shouldAddOffset() {
        let clause = parse("<T, U: A, V: A & B>")
        XCTAssertEqual(clause.offset, 0)
        XCTAssertEqual(clause.parameters[0].offset, 1)
        XCTAssertEqual(clause.parameters[0].length, 1)
        XCTAssertEqual(clause.parameters[1].offset, 4)
        XCTAssertEqual(clause.parameters[1].length, 4)
        XCTAssertEqual(clause.parameters[2].offset, 10)
        XCTAssertEqual(clause.parameters[2].length, 8)
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
