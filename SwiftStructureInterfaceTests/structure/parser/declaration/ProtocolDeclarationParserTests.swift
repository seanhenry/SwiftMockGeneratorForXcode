import XCTest
@testable import SwiftStructureInterface

class ProtocolDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseProtocol() {
        let text = "protocol P {}"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "P")
        XCTAssertEqual(`protocol`.bodyOffset, 12)
        XCTAssertEqual(`protocol`.bodyLength, 0)
        XCTAssertEqual(`protocol`.accessLevelModifier.text, "")
    }

    func test_parse_shouldParsePartialProtocolWithoutClosingBrace() {
        let text = "protocol A {"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.bodyOffset, 12)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParsePartialProtocolWithoutOpeningBrace() {
        let text = "protocol A"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.bodyOffset, 10)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClause() {
        let text = "protocol A: B {}"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.bodyOffset, 15)
        XCTAssertEqual(`protocol`.bodyLength, 0)
        XCTAssertEqual(`protocol`.inheritedTypes.count, 1)
        assertElementText(`protocol`.inheritedTypes[0], "B", offset: 12)
    }

    func test_parse_shouldParseInheritanceClauseWithMultipleInheritanceTypes() {
        let `protocol` = parse("protocol A: class, ProtocolB, P💐C {}")
        XCTAssertEqual(`protocol`.inheritedTypes.count, 3)
        assertElementText(`protocol`.inheritedTypes[0], "class", offset: 12)
        assertElementText(`protocol`.inheritedTypes[1], "ProtocolB", offset: 19)
        assertElementText(`protocol`.inheritedTypes[2], "P💐C", offset: 30)
    }

    func test_parse_shouldParseProtocolWithUTF16Characters() {
        let text = "protocol Na💐me: Pro💐tocol {}"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "Na💐me")
        XCTAssertEqual(`protocol`.bodyOffset, 33)
        XCTAssertEqual(`protocol`.bodyLength, 0)
        XCTAssertEqual(`protocol`.inheritedTypes.count, 1)
        assertElementText(`protocol`.inheritedTypes[0], "Pro💐tocol", offset: 19)
    }

    func test_parse_shouldParseProtocolWithAccessModifier() {
        let text = "public protocol A {}"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.bodyOffset, 19)
        XCTAssertEqual(`protocol`.bodyLength, 0)
        XCTAssertEqual(`protocol`.accessLevelModifier.text, "public")
    }

    func test_parse_shouldParseProtocolWithAttribute() {
        let text = "@objc(NS) protocol A {}"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.bodyOffset, 22)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithWhereClause() {
        let text = "protocol A where B: C {}"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.bodyOffset, 23)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClauseWithNestedTypes() {
        let `protocol` = parse("protocol A: Nested.Type, Deep.Nested.Type {}")
        XCTAssertEqual(`protocol`.inheritedTypes.count, 2)
        assertElementText(`protocol`.inheritedTypes[0], "Nested.Type", offset: 12)
        assertElementText(`protocol`.inheritedTypes[1], "Deep.Nested.Type", offset: 25)
    }

    func test_parse_shouldParseInheritanceTypeAsError_whenTypeIsMissing() {
        let text = "protocol A: {}"
        let `protocol` = parse(text)
        XCTAssertEqual(`protocol`.inheritedTypes.count, 1)
        XCTAssert(`protocol`.inheritedTypes[0] === SwiftType.errorType)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.bodyOffset, 13)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithoutName() {
        let text = "protocol {}"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "")
        XCTAssertEqual(`protocol`.bodyOffset, 10)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseComplicatedProtocol() {
        let text = "@objc(NSMyProtocol) @abc fileprivate protocol MyProtocol : InheritedType1, Deep.Nested.Type where Type : A & B , Type2 == N.T {}"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "MyProtocol")
        XCTAssertEqual(`protocol`.bodyOffset, `protocol`.length - 1)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClauseWithGenerics() {
        let text = "protocol A: Generic<Type> where Type.Type : Another<Generic> {}"
        let `protocol` = parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.bodyOffset, `protocol`.length - 1)
        XCTAssertEqual(`protocol`.bodyLength, 0)
        XCTAssertEqual(`protocol`.inheritedTypes.count, 1)
        assertElementText(`protocol`.inheritedTypes[0], "Generic<Type>", offset: 12)
    }

    func test_parse_shouldAddChildrenToProtocol() {
        let text = "protocol A: B { }"
        let `protocol` = parse(text)
        XCTAssert(`protocol`.children[0] === `protocol`.inheritedTypes[0])
    }

    // MARK: - Helpers

    func parse(_ text: String) -> TypeDeclaration {
        let parser = createDeclarationParser(text, .protocol, ProtocolDeclarationParser.self)
        return parser.parse()
    }
}
