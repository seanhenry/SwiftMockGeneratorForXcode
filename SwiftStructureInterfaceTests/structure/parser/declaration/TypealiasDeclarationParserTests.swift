import XCTest
@testable import SwiftStructureInterface

class TypealiasDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseDeclaration() throws {
        let text = "typealias Name = Int"
        let typeAlias = try parse(text)
        assertElementText(typeAlias, text)
        XCTAssertEqual(typeAlias.name, "Name")
        let assignment = typeAlias.typealiasAssignment
        assertElementText(assignment, "= Int")
        let type = assignment.type
        assertElementText(type, "Int")
    }

    func test_parse_shouldParseDeclarationWithoutName() throws {
        let text = "typealias = Int"
        let typeAlias = try parse(text)
        assertElementText(typeAlias, text)
        XCTAssertEqual(typeAlias.name, "")
    }

    func test_parse_shouldParseAttributesAndAccessLevelModifiers() throws {
        let text = "@a @b public typealias Name = Int"
        let typeAlias = try parse(text)
        assertElementText(typeAlias, text)
        XCTAssertEqual(typeAlias.name, "Name")
    }

    func test_parse_shouldParseGenericParameterClause() {
        let text = "typealias Name<T, U: V> = Int<T, U>"
        assertElementText(try parse(text), text)
    }

    func test_parse_shouldParseGenericParameterClauseWithMinimumWhitespace() {
        let text = "typealias Name<T,U:V,W==X>=Int<T>"
        assertElementText(try parse(text), text)
    }

    func test_parse_shouldParseGenericParameterClauseWithWhitespace() {
        let text = "typealias Name < T , U : V , W == X > = Int < T >"
        assertElementText(try parse(text), text)
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> TypealiasDeclaration {
        let parser = createDeclarationParser(text, .typealias, TypealiasDeclarationParser.self)
        return try parser.parse()
    }
}
