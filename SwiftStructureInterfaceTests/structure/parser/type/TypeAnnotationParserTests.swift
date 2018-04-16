import XCTest
@testable import SwiftStructureInterface

class TypeAnnotationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseAttributes() {
        let annotation = parse(": @a @b")
        XCTAssertEqual(annotation.attributes[0], "@a")
        XCTAssertEqual(annotation.attributes[1], "@b")
    }

    func test_parse_shouldParseInout() {
        let annotation = parse(": inout")
        XCTAssertTrue(annotation.isInout)
    }

    func test_parse_shouldParseType() {
        let annotation = parse(": String")
        let type = annotation.type as! TypeIdentifier
        XCTAssertFalse(annotation.isInout)
        XCTAssertEqual(type.text, "String")
    }

    func test_parse_shouldParseComplexAnnotation() {
        let annotation = parse(": @a @b inout [A]")
        let type = annotation.type as! ArrayType
        XCTAssertEqual(type.text, "[A]")
        XCTAssertEqual(annotation.attributes[0], "@a")
        XCTAssertEqual(annotation.attributes[1], "@b")
        XCTAssertTrue(annotation.isInout)
    }

    func test_parse_shouldSetChildren() {
        let annotation = parse(": A")
        XCTAssert(annotation.children[0] === annotation.type)
    }

    func parse(_ text: String) -> TypeAnnotation {
        return createParser(text, TypeAnnotationParser.self).parse()
    }
}
