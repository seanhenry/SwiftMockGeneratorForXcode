import XCTest
@testable import SwiftStructureInterface

class ProtocolCompositionParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldNotParseType() {
        assertConformance("Type", "")
    }

    func test_parse_shouldParseComposition() {
        assertConformance("A & B", "A & B")
    }

    func test_parse_shouldNotParseIncomplete() {
        assertConformance("A &", "")
    }

    func test_parse_shouldNotParseIncorrectComposition() {
        assertConformance("A & 0", "")
    }

    func test_parse_shouldNotParseIncorrectBinaryOperator() {
        assertConformance("A | B", "")
    }

    func test_parse_shouldParseMultipleComposition() {
        assertConformance("A & B & C & D", "A & B & C & D")
    }

    func test_parse_shouldParseWhenFirstIsCorrectButNextIsWrong() {
        assertConformance("A & B | C", "A & B")
        assertConformance("A & B & 0", "A & B & ")
    }

    // MARK: - Helpers

    func assertConformance(_ input: String, _ expected: String, line: UInt = #line) {
        XCTAssertEqual(createParser(input, ProtocolCompositionParser.self).parse(), expected, line: line)
    }
}
