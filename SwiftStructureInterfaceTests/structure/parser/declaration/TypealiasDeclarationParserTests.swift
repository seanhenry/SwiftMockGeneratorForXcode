import XCTest
@testable import SwiftStructureInterface

class TypealiasDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseDeclaration() {
        let text = "typealias Name = Type"
        let typeAlias = parse(text)
        assertElementText(typeAlias, text)
        XCTAssertEqual(typeAlias.name, "Name")
        XCTAssertEqual(typeAlias.children.count, 1)
        let assignment = typeAlias.typealiasAssignment
        XCTAssert(typeAlias.children.first === assignment)
        assertElementText(assignment, "= Type", offset: 15)
        let type = assignment.type
        XCTAssertEqual(assignment.children.count, 1)
        XCTAssert(assignment.children.first === type)
        assertElementText(type, "Type", offset: 17)
    }

    func test_parse_shouldParseDeclarationWithoutName() {
        let text = "typealias = Type"
        let typeAlias = parse(text)
        assertElementText(typeAlias, text)
        XCTAssertEqual(typeAlias.name, "")
        XCTAssertEqual(typeAlias.children.count, 1)
    }

    func test_parse_shouldParseAttributesAndAccessLevelModifiers() {
        let text = "@a @b public typealias Name = Type"
        let typeAlias = parse(text)
        assertElementText(typeAlias, text)
        XCTAssertEqual(typeAlias.name, "Name")
    }

    func test_parse_shouldParseGenericParameterClause() {
        let text = "typealias Name<T, U: V> = Type<T, U>"
        let typeAlias = parse(text)
        assertElementText(typeAlias, text)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> TypealiasDeclaration {
        let parser = createDeclarationParser(text, .typealias, TypealiasDeclarationParser.self)
        return parser.parse()
    }
}
