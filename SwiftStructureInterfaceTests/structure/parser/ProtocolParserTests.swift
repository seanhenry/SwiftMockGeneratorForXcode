import XCTest
@testable import SwiftStructureInterface

class ProtocolParserTests: XCTestCase {

    var parser: FileParser!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseProtocol() {
        parser = FileParser(fileContents: "protocol P {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol P {}")
        XCTAssertEqual(`protocol`?.name, "P")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 13)
        XCTAssertEqual(`protocol`?.bodyOffset, 12)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParsePartialProtocolWithoutClosingBrace() {
        parser = FileParser(fileContents: "protocol A {")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol A {")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 12)
        XCTAssertEqual(`protocol`?.bodyOffset, 12)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParsePartialProtocolWithoutOpeningBrace() {
        parser = FileParser(fileContents: "protocol A")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol A")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 10)
        XCTAssertEqual(`protocol`?.bodyOffset, 10)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClause() {
        parser = FileParser(fileContents: "protocol A: B {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol A: B {}")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 16)
        XCTAssertEqual(`protocol`?.bodyOffset, 15)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
        XCTAssertEqual(`protocol`?.inheritedTypes.count, 1)
        XCTAssertEqual(`protocol`?.inheritedTypes[0].name, "B")
        XCTAssertEqual(`protocol`?.inheritedTypes[0].text, "B")
        XCTAssertEqual(`protocol`?.inheritedTypes[0].offset, 12)
        XCTAssertEqual(`protocol`?.inheritedTypes[0].length, 1)
    }

    func test_parse_shouldParseInheritanceClauseWithMultipleInheritanceTypes() {
        parser = FileParser(fileContents: "protocol A: class, ProtocolB, P💐C {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.inheritedTypes.count, 3)
        XCTAssertEqual(`protocol`?.inheritedTypes[0].name, "class")
        XCTAssertEqual(`protocol`?.inheritedTypes[0].text, "class")
        XCTAssertEqual(`protocol`?.inheritedTypes[0].offset, 12)
        XCTAssertEqual(`protocol`?.inheritedTypes[0].length, 5)
        XCTAssertEqual(`protocol`?.inheritedTypes[1].name, "ProtocolB")
        XCTAssertEqual(`protocol`?.inheritedTypes[1].text, "ProtocolB")
        XCTAssertEqual(`protocol`?.inheritedTypes[1].offset, 19)
        XCTAssertEqual(`protocol`?.inheritedTypes[1].length, 9)
        XCTAssertEqual(`protocol`?.inheritedTypes[2].name, "P💐C")
        XCTAssertEqual(`protocol`?.inheritedTypes[2].text, "P💐C")
        XCTAssertEqual(`protocol`?.inheritedTypes[2].offset, 30)
        XCTAssertEqual(`protocol`?.inheritedTypes[2].length, 6)
    }

    func test_parse_shouldParseProtocolWithUTF16Characters() {
        parser = FileParser(fileContents: "protocol Na💐me: Pro💐tocol {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol Na💐me: Pro💐tocol {}")
        XCTAssertEqual(`protocol`?.name, "Na💐me")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 34)
        XCTAssertEqual(`protocol`?.bodyOffset, 33)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
        XCTAssertEqual(`protocol`?.inheritedTypes.count, 1)
        XCTAssertEqual(`protocol`?.inheritedTypes[0].name, "Pro💐tocol")
        XCTAssertEqual(`protocol`?.inheritedTypes[0].text, "Pro💐tocol")
        XCTAssertEqual(`protocol`?.inheritedTypes[0].offset, 19)
        XCTAssertEqual(`protocol`?.inheritedTypes[0].length, 12)
    }

    func test_parse_shouldParseProtocolWithAccessModifier() {
        parser = FileParser(fileContents: "public protocol A {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "public protocol A {}")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 20)
        XCTAssertEqual(`protocol`?.bodyOffset, 19)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithMisspelledAccessModifier() {
        parser = FileParser(fileContents: "publi protocol A {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol A {}")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 6)
        XCTAssertEqual(`protocol`?.length, 13)
        XCTAssertEqual(`protocol`?.bodyOffset, 18)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithAttribute() {
        parser = FileParser(fileContents: "@objc(NS) protocol A {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "@objc(NS) protocol A {}")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 23)
        XCTAssertEqual(`protocol`?.bodyOffset, 22)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClauseWithNestedTypes() {
        parser = FileParser(fileContents: "protocol A: Nested.Type, Deep.Nested.Type {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.inheritedTypes.count, 2)
        XCTAssertEqual(`protocol`?.inheritedTypes[0].name, "Nested.Type")
        XCTAssertEqual(`protocol`?.inheritedTypes[0].text, "Nested.Type")
        XCTAssertEqual(`protocol`?.inheritedTypes[0].offset, 12)
        XCTAssertEqual(`protocol`?.inheritedTypes[0].length, 11)
        XCTAssertEqual(`protocol`?.inheritedTypes[1].name, "Deep.Nested.Type")
        XCTAssertEqual(`protocol`?.inheritedTypes[1].text, "Deep.Nested.Type")
        XCTAssertEqual(`protocol`?.inheritedTypes[1].offset, 25)
        XCTAssertEqual(`protocol`?.inheritedTypes[1].length, 16)
    }

    func test_parse_shouldParseInheritanceTypeAsError_whenTypeIsMissing() {
        parser = FileParser(fileContents: "protocol A: {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.inheritedTypes.count, 1)
        XCTAssert(`protocol`?.inheritedTypes[0] === SwiftInheritedType.error)
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 14)
        XCTAssertEqual(`protocol`?.bodyOffset, 13)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithoutName() {
        parser = FileParser(fileContents: "protocol {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.name, "")
        XCTAssertEqual(`protocol`?.text, "protocol {}")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 11)
        XCTAssertEqual(`protocol`?.bodyOffset, 10)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }
}
