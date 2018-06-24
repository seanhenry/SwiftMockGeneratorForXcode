import XCTest
@testable import SwiftStructureInterface

class TypealiasAssignmentParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseAssignment() {
        let text = "= Anything<You.Like>"
        let associatedType = parse(text)
        assertElementText(associatedType, text)
    }

    func test_parse_shouldParseAssignmentWithNoWhitespace() {
        let text = "=Int"
        let associatedType = parse(text)
        assertElementText(associatedType, text)
    }

    func test_parse_shouldNotParseAssignmentWithoutEqualsOperator() {
        let text = "AType"
        XCTAssert(parse(text) === TypealiasAssignmentImpl.emptyTypealiasAssignment)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> ElementImpl {
        let parser = createParser(text, TypealiasAssignmentParser.self)
        return parser.parse() as! ElementImpl
    }
}
