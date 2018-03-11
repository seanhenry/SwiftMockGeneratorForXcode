import XCTest
@testable import SwiftStructureInterface


class FunctionDeclarationResultParserTests: XCTestCase {

    var parser: Parser<NamedElement>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseEmptyResult() {
        let result = parse("")
        XCTAssert(result === SwiftType.errorType)
    }

    func test_parse_shouldParseSimpleResult() {
        let result = parse("-> A")
        XCTAssertEqual(result.text, "A")
        XCTAssertEqual(result.offset, 3)
        XCTAssertEqual(result.length, 1)
    }

    func test_parse_shouldNotParseWithMissingArrow() {
        let result = parse("A")
        XCTAssert(result === SwiftType.errorType)
    }

    func test_parse_shouldParseComplexType() {
        let result = parse("-> A.B<[Type?]>?")
        XCTAssertEqual(result.text, "A.B<[Type?]>?")
        XCTAssertEqual(result.offset, 3)
        XCTAssertEqual(result.length, 13)
    }

    func test_parse_shouldParseAttributesBeforeType() {
        let result = parse("@a @b(c) -> Type")
        XCTAssertEqual(result.text, "Type")
        XCTAssertEqual(result.offset, 12)
        XCTAssertEqual(result.length, 4)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> Element {
        let parser = createParser(text, FunctionDeclarationParser.ResultParser.self)
        return parser.parse()
    }
}
