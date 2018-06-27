import XCTest
@testable import SwiftStructureInterface

class TypeAnnotationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseAttributes() throws {
        let text = ": @a @b"
        let annotation = try parse(text)
        XCTAssertEqual(annotation.attributes.attributes[0].text, "@a")
        XCTAssertEqual(annotation.attributes.attributes[1].text, "@b")
        XCTAssertEqual(annotation.attributes.text, "@a @b")
        XCTAssertEqual(annotation.text, text)
    }

    func test_parse_shouldParseInout() throws {
        let text = ": inout"
        let annotation = try parse(text)
        XCTAssertTrue(annotation.isInout)
        XCTAssertEqual(annotation.text, text)
    }

    func test_parse_shouldParseType() throws {
        let text = ": String"
        let annotation = try parse(text)
        let type = annotation.type as! TypeIdentifier
        XCTAssertFalse(annotation.isInout)
        XCTAssertEqual(type.text, "String")
        XCTAssertEqual(annotation.text, text)
    }

    func test_parse_shouldParseComplexAnnotation() throws {
        let text = ": @a @b inout [A]"
        let annotation = try parse(text)
        let type = annotation.type as! ArrayType
        XCTAssertEqual(type.text, "[A]")
        XCTAssertEqual(annotation.attributes.attributes[0].text, "@a")
        XCTAssertEqual(annotation.attributes.attributes[1].text, "@b")
        XCTAssertTrue(annotation.isInout)
        XCTAssertEqual(annotation.text, text)
    }

    func test_parse_shouldParseNoWhitespace() throws {
        let text = ":A"
        let annotation = try parse(text)
        let type = annotation.type
        XCTAssertEqual(type.text, "A")
        XCTAssertEqual(annotation.text, text)
    }

    func test_parse_shouldNotParseWhenNotStartingWithColon() {
        XCTAssertThrowsError(try parse("A"))
    }

    func parse(_ text: String) throws -> TypeAnnotation {
        return try createParser(text, TypeAnnotationParser.self).parse()
    }
}
