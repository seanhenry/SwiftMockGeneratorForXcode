import XCTest
@testable import SwiftStructureInterface

class SubscriptDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseSubscriptHead() {
        assertElementIsParsed("@a public final subscript")
    }

    func test_parse_shouldParseSubscriptGenericParameterClause() {
        assertElementIsParsed("subscript<T: A, U>")
    }

    func test_parse_shouldParseSubscriptParameterClause() {
        assertElementIsParsed("subscript(a: A, _ b: B)")
    }

    func test_parse_shouldParseSubscriptResult() {
        assertElementIsParsed("subscript() -> @a A?")
    }

    func test_parse_shouldParseSubscriptWhereClause() {
        assertElementIsParsed("subscript() where T: U")
    }

    func test_parse_shouldParseSubscriptWithGetterSetterBlock() {
        assertElementIsParsed("subscript() { set get }")
    }

    // MARK: - Helpers

    func parse(_ text: String) -> SubscriptDeclaration {
        let parser = createDeclarationParser(text, .subscript, SubscriptDeclarationParser.self)
        return parser.parse()
    }

    func assertElementIsParsed(_ text: String, line: UInt = #line) {
        let initialiser = parse(text)
        XCTAssertEqual(initialiser.text, text, line: line)
        XCTAssertEqual(initialiser.offset, 0, line: line)
        XCTAssertEqual(initialiser.length, Int64(text.utf8.count), line: line)
    }
}
