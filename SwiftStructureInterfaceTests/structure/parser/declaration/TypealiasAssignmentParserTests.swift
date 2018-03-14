import XCTest
@testable import SwiftStructureInterface

class TypealiasAssignmentParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseAssignment() {
        let text = "= Any.Type<You.Like>"
        let associatedType = parse(text)
        assertElementText(associatedType, text)
    }

    func test_parse_shouldNotParseAssignmentWithoutEqualsOperator() {
        let text = "Type"
        XCTAssert(parse(text) === SwiftTypealiasAssignment.errorTypealiasAssignment)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> SwiftElement {
        let parser = createParser(text, TypealiasAssignmentParser.self)
        return parser.parse() as! SwiftElement
    }
}
