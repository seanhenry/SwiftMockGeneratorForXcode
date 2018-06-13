import XCTest
@testable import SwiftStructureInterface

class InitializerDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyInit() {
        let initializer = parse("init()")
        XCTAssert(initializer.parameters.isEmpty)
        XCTAssertFalse(initializer.throws)
        XCTAssertFalse(initializer.rethrows)
        XCTAssertFalse(initializer.isFailable)
        XCTAssertEqual(initializer.text, "init()")
    }

    func test_parse_shouldParseEmptyOptionalInit() {
        let initializer = parse("init?()")
        XCTAssert(initializer.parameters.isEmpty)
        XCTAssertFalse(initializer.throws)
        XCTAssertFalse(initializer.rethrows)
        XCTAssert(initializer.isFailable)
        XCTAssertEqual(initializer.text, "init?()")
    }

    func test_parse_shouldParseEmptyIUOInit() {
        let initializer = parse("init!()")
        XCTAssert(initializer.parameters.isEmpty)
        XCTAssertFalse(initializer.throws)
        XCTAssertFalse(initializer.rethrows)
        XCTAssert(initializer.isFailable)
        XCTAssertEqual(initializer.text, "init!()")
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
        let initializer = parse("init(a: A, b: B)")
        XCTAssertEqual(initializer.parameters.count, 2)
        XCTAssertEqual(initializer.parameters[0].text, "a: A")
        XCTAssertEqual(initializer.parameters[1].text, "b: B")
        XCTAssert(initializer.children[0] === initializer.parameters[0])
        XCTAssert(initializer.children[1] === initializer.parameters[1])
        XCTAssertEqual(initializer.text, "init(a: A, b: B)")
    }

    func test_parse_shouldParseThrows() {
        let initializer = parse("init() throws")
        XCTAssert(initializer.throws)
        XCTAssertFalse(initializer.rethrows)
    }

    func test_parse_shouldParseRethrows() {
        let initializer = parse("init() rethrows")
        XCTAssertFalse(initializer.throws)
        XCTAssert(initializer.rethrows)
    }

    func test_parse_shouldParseGenericWhereClause() {
        assertElementIsParsed("init() where A.Type: Element, B.C == A.Type")
        assertElementIsParsed("init() where A.Type: Element, B.C == A.Type")
    }

    // MARK: - Helpers

    func parse(_ text: String) -> InitializerDeclaration {
        let parser = createDeclarationParser(text, .init, InitializerDeclarationParser.self)
        return parser.parse()
    }

    func assertElementIsParsed(_ text: String, line: UInt = #line) {
        let initializer = parse(text)
        XCTAssertEqual(initializer.text, text, line: line)
        XCTAssertEqual(initializer.offset, 0, line: line)
        XCTAssertEqual(initializer.length, Int64(text.utf8.count), line: line)
    }
}
