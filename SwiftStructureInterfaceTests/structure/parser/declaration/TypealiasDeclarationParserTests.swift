import XCTest
@testable import SwiftStructureInterface

class TypealiasDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseDeclaration() {
        let text = "typealias Name = Type"
        let typeAlias = parse(text)
        XCTAssertEqual(typeAlias.text, text)
        XCTAssertEqual(typeAlias.name, "Name")
        XCTAssertEqual(typeAlias.offset, 0)
        XCTAssertEqual(typeAlias.length, Int64(text.utf8.count))
        XCTAssertEqual(typeAlias.children.count, 1)
        let assignment = typeAlias.typealiasAssignment
        XCTAssert(typeAlias.children.first === assignment)
        XCTAssertEqual(assignment.text, "= Type")
        XCTAssertEqual(assignment.offset, 15)
        XCTAssertEqual(assignment.length, 6)
        let type = assignment.type
        XCTAssertEqual(assignment.children.count, 1)
        XCTAssert(assignment.children.first === type)
        XCTAssertEqual(type.text, "Type")
        XCTAssertEqual(type.offset, 17)
        XCTAssertEqual(type.length, 4)
    }

    func test_parse_shouldParseDeclarationWithoutName() {
        let text = "typealias = Type"
        let typeAlias = parse(text)
        XCTAssertEqual(typeAlias.text, text)
        XCTAssertEqual(typeAlias.name, "")
        XCTAssertEqual(typeAlias.offset, 0)
        XCTAssertEqual(typeAlias.length, Int64(text.utf8.count))
        XCTAssertEqual(typeAlias.children.count, 1)
    }

    func test_parse_shouldParseAttributesAndAccessLevelModifiers() {
        let text = "@a @b public typealias Name = Type"
        let typeAlias = parse(text)
        XCTAssertEqual(typeAlias.text, text)
        XCTAssertEqual(typeAlias.name, "Name")
        XCTAssertEqual(typeAlias.offset, 0)
        XCTAssertEqual(typeAlias.length, Int64(text.utf8.count))
    }

    func test_parse_shouldParseGenericParameterClause() {
        let text = "typealias Name<T, U: V> = Type<T, U>"
        let typeAlias = parse(text)
        XCTAssertEqual(typeAlias.text, text)
        XCTAssertEqual(typeAlias.offset, 0)
        XCTAssertEqual(typeAlias.length, Int64(text.utf8.count))
    }

    // MARK: - Helpers

    func parse(_ text: String) -> Typealias {
        let parser = createDeclarationParser(text, .typealias, TypealiasDeclarationParser.self)
        return parser.parse()
    }
}
