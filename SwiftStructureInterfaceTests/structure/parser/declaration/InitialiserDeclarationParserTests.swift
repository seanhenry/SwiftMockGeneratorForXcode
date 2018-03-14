import XCTest
@testable import SwiftStructureInterface

class InitialiserDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyInit() {
        assertElementIsParsed("init()")
    }

    func test_parse_shouldParseEmptyOptionalInit() {
        assertElementIsParsed("init?()")
    }

    func test_parse_shouldParseEmptyIUOInit() {
        assertElementIsParsed("init!()")
    }

    func test_parse_shouldParseEmptyAttributesAndModifiers() {
        assertElementIsParsed("@a public init()")
    }

    func test_parse_shouldParseGenericParameterClause() {
        assertElementIsParsed("init<T, U: Element>()")
        assertElementIsParsed("init?<T, U: Element>()")
        assertElementIsParsed("init!<T, U: Element>()")
    }

    func test_parse_shouldParseParameterClause() {
        assertElementIsParsed("init(a: A, b: B)")
    }

    func test_parse_shouldParseThrows() {
        assertElementIsParsed("init() throws")
        assertElementIsParsed("init() rethrows")
    }

    func test_parse_shouldParseGenericWhereClause() {
        assertElementIsParsed("init() where A.Type: Element, B.C == A.Type")
        assertElementIsParsed("init() where A.Type: Element, B.C == A.Type")
    }

    // MARK: - Helpers

    func parse(_ text: String) -> InitialiserDeclaration {
        let parser = createDeclarationParser(text, .init, InitialiserDeclarationParser.self)
        return parser.parse()
    }

    func assertElementIsParsed(_ text: String, line: UInt = #line) {
        let initialiser = parse(text)
        XCTAssertEqual(initialiser.text, text, line: line)
        XCTAssertEqual(initialiser.offset, 0, line: line)
        XCTAssertEqual(initialiser.length, Int64(text.utf8.count), line: line)
    }
}
