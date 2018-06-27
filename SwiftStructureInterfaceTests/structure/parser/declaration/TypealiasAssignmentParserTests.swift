import XCTest
@testable import SwiftStructureInterface

class TypealiasAssignmentParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseAssignment() {
        let text = "= Anything<You.Like>"
        assertElementText(try parse(text), text)
    }

    func test_parse_shouldParseAssignmentWithNoWhitespace() throws {
        let text = "<T>=A"
        let parser = createParser(text, TypealiasAssignmentParser.self)
        _ = try parser.parseGenericParameterClause()
        assertElementText(try parser.parse(), "=A")
    }

    func test_parse_shouldNotParseAssignmentWithoutEqualsOperator() {
        let text = "AType"
        XCTAssertThrowsError(try parse(text))
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> TypealiasAssignment {
        let parser = createParser(text, TypealiasAssignmentParser.self)
        return try parser.parse()
    }
}
