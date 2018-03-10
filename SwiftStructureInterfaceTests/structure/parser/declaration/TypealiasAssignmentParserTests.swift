import XCTest
@testable import SwiftStructureInterface

class TypealiasAssignmentParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseAssignment() {
        let text = "= Any.Type<You.Like>"
        let associatedType = parse(text)
        XCTAssertEqual(associatedType.text, text)
        XCTAssertEqual(associatedType.offset, 0)
        XCTAssertEqual(associatedType.length, Int64(text.utf8.count))
    }

    func test_parse_shouldNotParseAssignmentWithoutEqualsOperator() {
        let text = "Type"
        XCTAssert(parse(text) === SwiftElement.errorElement)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> SwiftElement {
        let parser = createParser(text, TypealiasAssignmentParser.self)
        return parser.parse() as! SwiftElement
    }
}
