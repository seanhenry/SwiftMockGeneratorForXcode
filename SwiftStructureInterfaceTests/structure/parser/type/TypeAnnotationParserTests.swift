import XCTest
@testable import SwiftStructureInterface

class TypeAnnotationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseAttributes() {
        let text = ": @a @b"
        let annotation = parse(text)
        XCTAssertEqual(annotation.attributes.attributes[0].text, "@a")
        XCTAssertEqual(annotation.attributes.attributes[1].text, "@b")
        XCTAssertEqual(annotation.attributes.text, "@a @b")
        XCTAssertEqual(annotation.text, text)
    }

    func test_parse_shouldParseInout() {
        let text = ": inout"
        let annotation = parse(text)
        XCTAssertTrue(annotation.isInout)
        XCTAssertEqual(annotation.text, text)
    }

    func test_parse_shouldParseType() {
        let text = ": String"
        let annotation = parse(text)
        let type = annotation.type as! TypeIdentifier
        XCTAssertFalse(annotation.isInout)
        XCTAssertEqual(type.text, "String")
        XCTAssertEqual(annotation.text, text)
    }

    func test_parse_shouldParseComplexAnnotation() {
        let text = ": @a @b inout [A]"
        let annotation = parse(text)
        let type = annotation.type as! ArrayType
        XCTAssertEqual(type.text, "[A]")
        XCTAssertEqual(annotation.attributes.attributes[0].text, "@a")
        XCTAssertEqual(annotation.attributes.attributes[1].text, "@b")
        XCTAssertTrue(annotation.isInout)
        XCTAssertEqual(annotation.text, text)
    }

    func test_parse_shouldParseNoWhitespace() {
        let text = ":A"
        let annotation = parse(text)
        let type = annotation.type
        XCTAssertEqual(type.text, "A")
        XCTAssertEqual(annotation.text, text)
    }

    func parse(_ text: String) -> TypeAnnotation {
        return createParser(text, TypeAnnotationParser.self).parse()
    }
}
