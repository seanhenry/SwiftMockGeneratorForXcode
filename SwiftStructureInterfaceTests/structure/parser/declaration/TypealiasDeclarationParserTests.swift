import XCTest
@testable import SwiftStructureInterface

class TypealiasDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseDeclaration() {
        let text = "typealias Name = Int"
        let typeAlias = parse(text)
        assertElementText(typeAlias, text)
        XCTAssertEqual(typeAlias.name, "Name")
        let assignment = typeAlias.typealiasAssignment
        assertElementText(assignment, "= Int")
        let type = assignment.type
        assertElementText(type, "Int")
    }

    func test_parse_shouldParseDeclarationWithoutName() {
        let text = "typealias = Int"
        let typeAlias = parse(text)
        assertElementText(typeAlias, text)
        XCTAssertEqual(typeAlias.name, "")
    }

    func test_parse_shouldParseAttributesAndAccessLevelModifiers() {
        let text = "@a @b public typealias Name = Int"
        let typeAlias = parse(text)
        assertElementText(typeAlias, text)
        XCTAssertEqual(typeAlias.name, "Name")
    }

    func test_parse_shouldParseGenericParameterClause() {
        let text = "typealias Name<T, U: V> = Int<T, U>"
        let typeAlias = parse(text)
        assertElementText(typeAlias, text)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> TypealiasDeclaration {
        let parser = createDeclarationParser(text, .typealias, TypealiasDeclarationParser.self)
        return parser.parse()
    }
}
