import XCTest
@testable import SwiftStructureInterface

class AssociatedTypeDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldAssociatedTypeWithName() throws {
        let text = "associatedtype Name"
        let associatedType = try parse(text)
        assertElementText(associatedType, text)
    }

    func test_parse_shouldAssociatedTypeWithoutName() throws {
        let text = "associatedtype :"
        let associatedType = try parse(text)
        assertElementText(associatedType, text)
    }

    func test_parse_shouldAssociatedTypeWithAttributesAndAccesModifier() throws {
        let text = "@a @b public associatedtype Name"
        let associatedType = try parse(text)
        assertElementText(associatedType, text)
    }

    func test_parse_shouldAssociatedTypeWithTypeInheritanceClause() throws {
        let text = "associatedtype Name: Int, List<Of.Types>"
        let associatedType = try parse(text)
        assertElementText(associatedType, text)
    }

    func test_parse_shouldAssociatedTypeWithTypealiasAssignment() throws {
        let text = "associatedtype Name = Int"
        let associatedType = try parse(text)
        assertElementText(associatedType, text)
    }

    func test_parse_shouldAssociatedTypeWithWhereClause() throws {
        let text = "associatedtype Name where T: A"
        let associatedType = try parse(text)
        assertElementText(associatedType, text)
    }

    func test_parse_shouldAssociatedTypeWithEverything() throws {
        let text = "@a open associatedtype Name: T where T.Element: A"
        let associatedType = try parse(text)
        assertElementText(associatedType, text)
    }

    func test_parse_shouldParseKeywordType() throws {
        let text = "associatedtype indirect"
        let associatedType = try parse(text)
        assertElementText(associatedType, text)
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> Element {
        let parser = createDeclarationParser(text, .identifier("associatedtype", false), AssociatedTypeDeclarationParser.self)
        return try parser.parse()
    }
}
