import XCTest
@testable import SwiftStructureInterface

class AssociatedTypeDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldAssociatedTypeWithName() {
        let text = "associatedtype Name"
        let associatedType = parse(text)
        XCTAssertEqual(associatedType.text, text)
        XCTAssertEqual(associatedType.offset, 0)
        XCTAssertEqual(associatedType.length, Int64(text.utf8.count))
    }

    func test_parse_shouldAssociatedTypeWithoutName() {
        let text = "associatedtype :"
        let associatedType = parse(text)
        XCTAssertEqual(associatedType.text, text)
        XCTAssertEqual(associatedType.offset, 0)
        XCTAssertEqual(associatedType.length, Int64(text.utf8.count))
    }

    func test_parse_shouldAssociatedTypeWithAttributesAndAccesModifier() {
        let text = "@a @b public associatedtype Name"
        let associatedType = parse(text)
        XCTAssertEqual(associatedType.text, text)
        XCTAssertEqual(associatedType.offset, 0)
        XCTAssertEqual(associatedType.length, Int64(text.utf8.count))
    }

    func test_parse_shouldAssociatedTypeWithTypeInheritanceClause() {
        let text = "associatedtype Name: Type, List<Of.Types>"
        let associatedType = parse(text)
        XCTAssertEqual(associatedType.text, text)
        XCTAssertEqual(associatedType.offset, 0)
        XCTAssertEqual(associatedType.length, Int64(text.utf8.count))
    }

    func test_parse_shouldAssociatedTypeWithTypealiasAssignment() {
        let text = "associatedtype Name = Type"
        let associatedType = parse(text)
        XCTAssertEqual(associatedType.text, text)
        XCTAssertEqual(associatedType.offset, 0)
        XCTAssertEqual(associatedType.length, Int64(text.utf8.count))
    }

    func test_parse_shouldAssociatedTypeWithWhereClause() {
        let text = "associatedtype Name where T: A"
        let associatedType = parse(text)
        XCTAssertEqual(associatedType.text, text)
        XCTAssertEqual(associatedType.offset, 0)
        XCTAssertEqual(associatedType.length, Int64(text.utf8.count))
    }

    func test_parse_shouldAssociatedTypeWithEverything() {
        let text = "@a open associatedtype Name: T where T.Element: A"
        let associatedType = parse(text)
        XCTAssertEqual(associatedType.text, text)
        XCTAssertEqual(associatedType.offset, 0)
        XCTAssertEqual(associatedType.length, Int64(text.utf8.count))
    }

    // MARK: - Helpers

    func parse(_ text: String) -> SwiftElement {
        let parser = createDeclarationParser(text, .identifier("associatedtype"), AssociatedTypeDeclarationParser.self)
        return parser.parse() as! SwiftElement
    }
}
