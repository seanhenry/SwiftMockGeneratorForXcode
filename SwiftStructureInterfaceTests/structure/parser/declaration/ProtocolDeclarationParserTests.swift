import XCTest
@testable import SwiftStructureInterface

class ProtocolDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseProtocol() {
        let `protocol` = parse("protocol P {}")
        XCTAssertEqual(`protocol`.text, "protocol P {}")
        XCTAssertEqual(`protocol`.name, "P")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 13)
        XCTAssertEqual(`protocol`.bodyOffset, 12)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParsePartialProtocolWithoutClosingBrace() {
        let `protocol` = parse("protocol A {")
        XCTAssertEqual(`protocol`.text, "protocol A {")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 12)
        XCTAssertEqual(`protocol`.bodyOffset, 12)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParsePartialProtocolWithoutOpeningBrace() {
        let `protocol` = parse("protocol A")
        XCTAssertEqual(`protocol`.text, "protocol A")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 10)
        XCTAssertEqual(`protocol`.bodyOffset, 10)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClause() {
        let `protocol` = parse("protocol A: B {}")
        XCTAssertEqual(`protocol`.text, "protocol A: B {}")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 16)
        XCTAssertEqual(`protocol`.bodyOffset, 15)
        XCTAssertEqual(`protocol`.bodyLength, 0)
        XCTAssertEqual(`protocol`.inheritedTypes.count, 1)
        XCTAssertEqual(`protocol`.inheritedTypes[0].name, "B")
        XCTAssertEqual(`protocol`.inheritedTypes[0].text, "B")
        XCTAssertEqual(`protocol`.inheritedTypes[0].offset, 12)
        XCTAssertEqual(`protocol`.inheritedTypes[0].length, 1)
    }

    func test_parse_shouldParseInheritanceClauseWithMultipleInheritanceTypes() {
        let `protocol` = parse("protocol A: class, ProtocolB, P💐C {}")
        XCTAssertEqual(`protocol`.inheritedTypes.count, 3)
        XCTAssertEqual(`protocol`.inheritedTypes[0].name, "class")
        XCTAssertEqual(`protocol`.inheritedTypes[0].text, "class")
        XCTAssertEqual(`protocol`.inheritedTypes[0].offset, 12)
        XCTAssertEqual(`protocol`.inheritedTypes[0].length, 5)
        XCTAssertEqual(`protocol`.inheritedTypes[1].name, "ProtocolB")
        XCTAssertEqual(`protocol`.inheritedTypes[1].text, "ProtocolB")
        XCTAssertEqual(`protocol`.inheritedTypes[1].offset, 19)
        XCTAssertEqual(`protocol`.inheritedTypes[1].length, 9)
        XCTAssertEqual(`protocol`.inheritedTypes[2].name, "P💐C")
        XCTAssertEqual(`protocol`.inheritedTypes[2].text, "P💐C")
        XCTAssertEqual(`protocol`.inheritedTypes[2].offset, 30)
        XCTAssertEqual(`protocol`.inheritedTypes[2].length, 6)
    }

    func test_parse_shouldParseProtocolWithUTF16Characters() {
        let `protocol` = parse("protocol Na💐me: Pro💐tocol {}")
        XCTAssertEqual(`protocol`.text, "protocol Na💐me: Pro💐tocol {}")
        XCTAssertEqual(`protocol`.name, "Na💐me")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 34)
        XCTAssertEqual(`protocol`.bodyOffset, 33)
        XCTAssertEqual(`protocol`.bodyLength, 0)
        XCTAssertEqual(`protocol`.inheritedTypes.count, 1)
        XCTAssertEqual(`protocol`.inheritedTypes[0].name, "Pro💐tocol")
        XCTAssertEqual(`protocol`.inheritedTypes[0].text, "Pro💐tocol")
        XCTAssertEqual(`protocol`.inheritedTypes[0].offset, 19)
        XCTAssertEqual(`protocol`.inheritedTypes[0].length, 12)
    }

    func test_parse_shouldParseProtocolWithAccessModifier() {
        let `protocol` = parse("public protocol A {}")
        XCTAssertEqual(`protocol`.text, "public protocol A {}")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 20)
        XCTAssertEqual(`protocol`.bodyOffset, 19)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithAttribute() {
        let `protocol` = parse("@objc(NS) protocol A {}")
        XCTAssertEqual(`protocol`.text, "@objc(NS) protocol A {}")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 23)
        XCTAssertEqual(`protocol`.bodyOffset, 22)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithWhereClause() {
        let `protocol` = parse("protocol A where B: C {}")
        XCTAssertEqual(`protocol`.text, "protocol A where B: C {}")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 24)
        XCTAssertEqual(`protocol`.bodyOffset, 23)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClauseWithNestedTypes() {
        let `protocol` = parse("protocol A: Nested.Type, Deep.Nested.Type {}")
        XCTAssertEqual(`protocol`.inheritedTypes.count, 2)
        XCTAssertEqual(`protocol`.inheritedTypes[0].name, "Nested.Type")
        XCTAssertEqual(`protocol`.inheritedTypes[0].text, "Nested.Type")
        XCTAssertEqual(`protocol`.inheritedTypes[0].offset, 12)
        XCTAssertEqual(`protocol`.inheritedTypes[0].length, 11)
        XCTAssertEqual(`protocol`.inheritedTypes[1].name, "Deep.Nested.Type")
        XCTAssertEqual(`protocol`.inheritedTypes[1].text, "Deep.Nested.Type")
        XCTAssertEqual(`protocol`.inheritedTypes[1].offset, 25)
        XCTAssertEqual(`protocol`.inheritedTypes[1].length, 16)
    }

    func test_parse_shouldParseInheritanceTypeAsError_whenTypeIsMissing() {
        let `protocol` = parse("protocol A: {}")
        XCTAssertEqual(`protocol`.inheritedTypes.count, 1)
        XCTAssert(`protocol`.inheritedTypes[0] === SwiftInheritedType.errorInheritedType)
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 14)
        XCTAssertEqual(`protocol`.bodyOffset, 13)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithoutName() {
        let `protocol` = parse("protocol {}")
        XCTAssertEqual(`protocol`.name, "")
        XCTAssertEqual(`protocol`.text, "protocol {}")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 11)
        XCTAssertEqual(`protocol`.bodyOffset, 10)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseComplicatedProtocol() {
        let text = "@objc(NSMyProtocol) @abc fileprivate protocol MyProtocol : InheritedType1, Deep.Nested.Type where Type : A & B , Type2 == N.T {}"
        let `protocol` = parse(text)
        XCTAssertEqual(`protocol`.name, "MyProtocol")
        XCTAssertEqual(`protocol`.text, text)
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, Int64(text.utf8.count))
        XCTAssertEqual(`protocol`.bodyOffset, Int64(text.utf8.count) - 1)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClauseWithGenerics() {
        let text = "protocol A: Generic<Type> where Type.Type : Another<Generic> {}"
        let `protocol` = parse(text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.text, text)
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, Int64(text.utf8.count))
        XCTAssertEqual(`protocol`.bodyOffset, Int64(text.utf8.count) - 1)
        XCTAssertEqual(`protocol`.bodyLength, 0)
        XCTAssertEqual(`protocol`.inheritedTypes.count, 1)
        XCTAssertEqual(`protocol`.inheritedTypes[0].name, "Generic<Type>")
        XCTAssertEqual(`protocol`.inheritedTypes[0].text, "Generic<Type>")
        XCTAssertEqual(`protocol`.inheritedTypes[0].offset, 12)
        XCTAssertEqual(`protocol`.inheritedTypes[0].length, 13)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> SwiftTypeElement {
        let parser = createDeclarationParser(text, .protocol, ProtocolDeclarationParser.self)
        return parser.parse()
    }
}
