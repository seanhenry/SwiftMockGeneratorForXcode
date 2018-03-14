import XCTest
@testable import SwiftStructureInterface

class InitialiserDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyInit() {
        let initialiser = parse("init()")
        XCTAssertEqual(initialiser.text, "init()")
        XCTAssertEqual(initialiser.offset, 0)
        XCTAssertEqual(initialiser.length, 6)
    }

    func test_parse_shouldParseEmptyOptionalInit() {
        let initialiser = parse("init?()")
        XCTAssertEqual(initialiser.text, "init?()")
        XCTAssertEqual(initialiser.offset, 0)
        XCTAssertEqual(initialiser.length, 7)
    }

    func test_parse_shouldParseEmptyIUOInit() {
        let initialiser = parse("init!()")
        XCTAssertEqual(initialiser.text, "init!()")
        XCTAssertEqual(initialiser.offset, 0)
        XCTAssertEqual(initialiser.length, 7)
    }

    func test_parse_shouldParseEmptyAttributesAndModifiers() {
        let initialiser = parse("@a public init()")
        XCTAssertEqual(initialiser.text, "@a public init()")
        XCTAssertEqual(initialiser.offset, 0)
        XCTAssertEqual(initialiser.length, 16)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> Initialiser {
        let parser = createDeclarationParser(text, .init, InitialiserDeclarationParser.self)
        return parser.parse()
    }
}
