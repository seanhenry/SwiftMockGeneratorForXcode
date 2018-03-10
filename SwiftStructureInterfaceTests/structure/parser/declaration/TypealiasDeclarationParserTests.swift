import XCTest
@testable import SwiftStructureInterface

class TypealiasDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseDeclaration() {
        let text = "typealias = Type"
        let associatedType = parse(text)
        XCTAssertEqual(associatedType.text, text)
        XCTAssertEqual(associatedType.offset, 0)
        XCTAssertEqual(associatedType.length, Int64(text.utf8.count))
    }

    // MARK: - Helpers

    func parse(_ text: String) -> SwiftElement {
        let parser = createDeclarationParser(text, .typealias, TypealiasDeclarationParser.self)
        return parser.parse() as! SwiftElement
    }
}
