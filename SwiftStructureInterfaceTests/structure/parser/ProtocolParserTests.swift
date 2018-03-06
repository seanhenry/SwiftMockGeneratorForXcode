import XCTest
@testable import SwiftStructureInterface

class ProtocolParserTests: XCTestCase {

    var parser: Parser<SwiftTypeElement>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseProtocol() {
        let parser = createParser("protocol P {}", ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.text, "protocol P {}")
        XCTAssertEqual(`protocol`.name, "P")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 13)
        XCTAssertEqual(`protocol`.bodyOffset, 12)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParsePartialProtocolWithoutClosingBrace() {
        parser = createParser("protocol A {", ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.text, "protocol A {")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 12)
        XCTAssertEqual(`protocol`.bodyOffset, 12)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParsePartialProtocolWithoutOpeningBrace() {
        parser = createParser("protocol A", ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.text, "protocol A")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 10)
        XCTAssertEqual(`protocol`.bodyOffset, 10)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClause() {
        parser = createParser("protocol A: B {}", ProtocolParser.self)
        let `protocol` = parser.parse()
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
        parser = createParser("protocol A: class, ProtocolB, P💐C {}", ProtocolParser.self)
        let `protocol` = parser.parse()
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
        parser = createParser("protocol Na💐me: Pro💐tocol {}", ProtocolParser.self)
        let `protocol` = parser.parse()
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
        parser = createParser("public protocol A {}", ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.text, "public protocol A {}")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 20)
        XCTAssertEqual(`protocol`.bodyOffset, 19)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithAttribute() {
        parser = createParser("@objc(NS) protocol A {}", ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.text, "@objc(NS) protocol A {}")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 23)
        XCTAssertEqual(`protocol`.bodyOffset, 22)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithWhereClause() {
        parser = createParser("protocol A where B: C {}", ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.text, "protocol A where B: C {}")
        XCTAssertEqual(`protocol`.name, "A")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 24)
        XCTAssertEqual(`protocol`.bodyOffset, 23)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClauseWithNestedTypes() {
        parser = createParser("protocol A: Nested.Type, Deep.Nested.Type {}", ProtocolParser.self)
        let `protocol` = parser.parse()
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
        parser = createParser("protocol A: {}", ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.inheritedTypes.count, 1)
        XCTAssert(`protocol`.inheritedTypes[0] === SwiftInheritedType.error)
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 14)
        XCTAssertEqual(`protocol`.bodyOffset, 13)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseProtocolWithoutName() {
        parser = createParser("protocol {}", ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.name, "")
        XCTAssertEqual(`protocol`.text, "protocol {}")
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, 11)
        XCTAssertEqual(`protocol`.bodyOffset, 10)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseComplicatedProtocol() {
        let text = "@objc(NSMyProtocol) @abc fileprivate protocol MyProtocol : InheritedType1, Deep.Nested.Type where Type : A & B , Type2 == N.T {}"
        parser = createParser(text, ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.name, "MyProtocol")
        XCTAssertEqual(`protocol`.text, text)
        XCTAssertEqual(`protocol`.offset, 0)
        XCTAssertEqual(`protocol`.length, Int64(text.utf8.count))
        XCTAssertEqual(`protocol`.bodyOffset, Int64(text.utf8.count) - 1)
        XCTAssertEqual(`protocol`.bodyLength, 0)
    }

    func test_parse_shouldParseInheritanceClauseWithGenerics() {
        let text = "protocol A: Generic<Type> where Type.Type : Another<Generic> {}"
        parser = createParser(text, ProtocolParser.self)
        let `protocol` = parser.parse()
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
}
