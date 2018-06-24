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
        XCTAssert(result === TypeImpl.emptyType)
    }

    func test_parse_shouldParseSimpleResult() {
        let result = parse("-> A")
        assertElementText(result, "A", offset: 3)
    }

    func test_parse_shouldNotParseWithMissingArrow() {
        let result = parse("A")
        XCTAssert(result === TypeImpl.emptyType)
    }

    func test_parse_shouldParseComplexType() {
        let result = parse("-> A.B<[Type?]>?")
        assertElementText(result, "A.B<[Type?]>?", offset: 3)
    }

    func test_parse_shouldParseAttributesBeforeType() {
        let result = parse("-> @a @b(c) Type")
        assertElementText(result, "Type", offset: 12)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> Element {
        let parser = createParser(text, FunctionDeclarationParser.ResultParser.self)
        return parser.parse()
    }
}
