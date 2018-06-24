import XCTest
@testable import SwiftStructureInterface

class ProtocolCompositionTypeParserTests: XCTestCase, TypeParserTests {

    // MARK: - Protocol composition

    func test_parse_shouldParseComposition() {
        assertTypeText("A & B", "A & B")
    }

    func test_parse_shouldNotParseIncomplete() {
        assertTypeText("A &", "A")
    }

    func test_parse_shouldNotParseIncorrectComposition() {
        assertTypeText("A & 0", "A")
    }

    func test_parse_shouldNotParseIncorrectBinaryOperator() {
        assertTypeText("A | B", "A")
    }

    func test_parse_shouldParseMultipleComposition() {
        assertTypeText("A & B & C & D", "A & B & C & D")
    }

    func test_parse_shouldParseWhenFirstIsCorrectButNextIsWrong() {
        assertTypeText("A & B | C", "A & B")
        assertTypeText("A & B & 0", "A & B & ")
    }

    func test_parse_shouldParseGenericTypes() {
        assertTypeText("A<T> & B<U>", "A<T> & B<U>")
    }

    func test_parse_shouldParseNestedTypes() {
        assertTypeText("A.B<T.U> & C.D<V.W>", "A.B<T.U> & C.D<V.W>")
    }

    func test_parse_shouldParseWithNoWhitespace() {
        assertTypeText("A&B", "A&B")
    }

    func test_parse_shouldParseProtocolCompositionElement() {
        let composition = parse("A & B & C") as! ProtocolCompositionType
        assertElementText(composition.types[0], "A")
        assertElementText(composition.types[1], "B", offset: 4)
        assertElementText(composition.types[2], "C", offset: 8)
    }
}
