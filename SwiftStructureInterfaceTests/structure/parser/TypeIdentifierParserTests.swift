import XCTest
@testable import SwiftStructureInterface

class TypeIdentifierParserTests: XCTestCase {

    var parser: Parser<String>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseSimpleType() {
        assertTypeName("Type", "Type")
    }

    func test_parse_shouldParseEmptyTypeAsError() {
        let element = createParser("", TypeIdentifierParser.self).parse()
        XCTAssert(element === SwiftInheritedType.error)
    }

    func test_parse_shouldParseNestedType() {
        assertTypeName("Swift.Type", "Swift.Type")
    }

    func test_parse_shouldParseDeeplyNestedType() {
        assertTypeName("Swift.Deep.Nested.Type", "Swift.Deep.Nested.Type")
    }
    
    // MARK: - Helpers

    func assertTypeName(_ input: String, _ expected: String, line: UInt = #line) {
        let element = createParser(input, TypeIdentifierParser.self).parse()
        XCTAssertEqual(element.name, expected, line: line)
    }
}
