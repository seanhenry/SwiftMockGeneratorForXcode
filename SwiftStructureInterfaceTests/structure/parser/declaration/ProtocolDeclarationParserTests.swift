import XCTest
@testable import SwiftStructureInterface

class ProtocolDeclarationParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseProtocol() throws {
        let text = "protocol P {}"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "P")
        XCTAssertEqual(`protocol`.accessLevelModifier.text, "")
    }

    func test_parse_shouldParsePartialProtocolWithoutClosingBrace() throws {
        let text = "protocol A {"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
    }

    func test_parse_shouldParsePartialProtocolWithoutOpeningBrace() throws {
        let text = "protocol A"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
    }

    func test_parse_shouldParseInheritanceClause() throws {
        let text = "protocol A: B {}"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.typeInheritanceClause.inheritedTypes.count, 1)
        assertElementText(`protocol`.typeInheritanceClause.inheritedTypes[0], "B", offset: 12)
    }

    func test_parse_shouldParseInheritanceClauseWithMultipleInheritanceTypes() throws {
        let `protocol` = try parse("protocol A: class, ProtocolB, P💐C {}")
        XCTAssertEqual(`protocol`.typeInheritanceClause.inheritedTypes.count, 3)
        assertElementText(`protocol`.typeInheritanceClause.inheritedTypes[0], "class", offset: 12)
        assertElementText(`protocol`.typeInheritanceClause.inheritedTypes[1], "ProtocolB", offset: 19)
        assertElementText(`protocol`.typeInheritanceClause.inheritedTypes[2], "P💐C", offset: 30)
    }

    func test_parse_shouldParseProtocolWithUTF16Characters() throws {
        let text = "protocol Na💐me: Pro💐tocol {}"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "Na💐me")
        XCTAssertEqual(`protocol`.typeInheritanceClause.inheritedTypes.count, 1)
        assertElementText(`protocol`.typeInheritanceClause.inheritedTypes[0], "Pro💐tocol", offset: 19)
    }

    func test_parse_shouldParseProtocolWithAccessModifier() throws {
        let text = "public protocol A {}"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.accessLevelModifier.text, "public")
    }

    func test_parse_shouldParseProtocolWithAttribute() throws {
        let text = "@objc(NS) protocol A {}"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
    }

    func test_parse_shouldParseProtocolWithWhereClause() throws {
        let text = "protocol A where B: C {}"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
    }

    func test_parse_shouldParseInheritanceClauseWithNestedTypes() throws {
        let `protocol` = try parse("protocol A: Nested.Type, Deep.Nested.Type {}")
        XCTAssertEqual(`protocol`.typeInheritanceClause.inheritedTypes.count, 2)
        assertElementText(`protocol`.typeInheritanceClause.inheritedTypes[0], "Nested.Type", offset: 12)
        assertElementText(`protocol`.typeInheritanceClause.inheritedTypes[1], "Deep.Nested.Type", offset: 25)
    }

    func test_parse_shouldParseInheritanceTypeAsError_whenTypeIsMissing() throws {
        let text = "protocol A: {}"
        let `protocol` = try parse(text)
        XCTAssertEqual(`protocol`.typeInheritanceClause.inheritedTypes.count, 0)
        assertElementText(`protocol`, text)
    }

    func test_parse_shouldParseProtocolWithoutName() throws {
        let text = "protocol {}"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "")
    }

    func test_parse_shouldParseComplicatedProtocol() throws {
        let text = "@objc(NSMyProtocol) @abc fileprivate protocol MyProtocol : InheritedType1, Deep.Nested.T where T : A & B , Type2 == N.T {}"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "MyProtocol")
    }

    func test_parse_shouldParseInheritanceClauseWithGenerics() throws {
        let text = "protocol A: Generic<T> where T.Type : Another<Generic> {}"
        let `protocol` = try parse(text)
        assertElementText(`protocol`, text)
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.typeInheritanceClause.inheritedTypes.count, 1)
        assertElementText(`protocol`.typeInheritanceClause.inheritedTypes[0], "Generic<T>", offset: 12)
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> TypeDeclaration {
        let parser = createDeclarationParser(text, .protocol, ProtocolDeclarationParser.self)
        return try parser.parse()
    }
}
