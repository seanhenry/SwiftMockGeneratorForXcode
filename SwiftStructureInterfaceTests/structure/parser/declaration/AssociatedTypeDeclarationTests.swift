import XCTest
@testable import SwiftStructureInterface

class AssociatedTypeDeclarationParserTests: XCTestCase {

    var parser: Parser<SwiftTypeElement>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

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

    // MARK: - Helpers

    func parse(_ text: String) -> SwiftElement {
        let parser = createDeclarationParser(text, .identifier("associatedtype"), AssociatedTypeDeclarationParser.self)
        return parser.parse() as! SwiftElement
    }
}
