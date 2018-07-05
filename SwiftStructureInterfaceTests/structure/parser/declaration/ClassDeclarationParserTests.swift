import XCTest
@testable import SwiftStructureInterface

class ClassDeclarationParserTests: XCTestCase {

    func test_parse_shouldParseClass() throws {
        let text = "class C {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "C")
        XCTAssertEqual(`class`.accessLevelModifier.text, "")
        XCTAssertFalse(`class`.isFinal)
        XCTAssertEqual(`class`.genericParameterClause.text, "")
    }

    func test_parse_shouldParsePartialClassWithoutClosingBrace() throws {
        let text = "class A {"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "A")
    }

    func test_parse_shouldParsePartialClassWithoutOpeningBrace() throws {
        let text = "class A"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "A")
    }

    func test_parse_shouldParseInheritanceClause() throws {
        let text = "class A: B {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "A")
        XCTAssertEqual(`class`.typeInheritanceClause.inheritedTypes.count, 1)
        assertElementText(`class`.typeInheritanceClause.inheritedTypes[0], "B")
    }

    func test_parse_shouldParseInheritanceClauseWithMultipleInheritanceTypes() throws {
        let `class` = try parse("class A: class, ClassB, P💐C {}")
        XCTAssertEqual(`class`.typeInheritanceClause.inheritedTypes.count, 3)
        assertElementText(`class`.typeInheritanceClause.inheritedTypes[0], "class")
        assertElementText(`class`.typeInheritanceClause.inheritedTypes[1], "ClassB")
        assertElementText(`class`.typeInheritanceClause.inheritedTypes[2], "P💐C")
    }

    func test_parse_shouldParseClassWithUTF16Characters() throws {
        let text = "class Na💐me: Cla💐ss {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "Na💐me")
        XCTAssertEqual(`class`.typeInheritanceClause.inheritedTypes.count, 1)
        assertElementText(`class`.typeInheritanceClause.inheritedTypes[0], "Cla💐ss")
    }

    func test_parse_shouldParseClassWithAccessModifier() throws {
        let text = "public class A {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "A")
        XCTAssertEqual(`class`.accessLevelModifier.text, "public")
    }

    func test_parse_shouldParseClassWithGenericParameterClause() throws {
        let text = "public class A<C, D> {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.genericParameterClause.text, "<C, D>")
    }

    func test_parse_shouldParseFinalClass() throws {
        let text = "public final class A {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssert(`class`.isFinal)
    }

    func test_parse_shouldParseClassWithAttribute() throws {
        let text = "@objc(NS) class A {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "A")
    }

    func test_parse_shouldParseClassWithWhereClause() throws {
        let text = "class A where B: C {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "A")
    }

    func test_parse_shouldParseInheritanceClauseWithNestedTypes() throws {
        let `class` = try parse("class A: Nested.Type, Deep.Nested.Type {}")
        XCTAssertEqual(`class`.typeInheritanceClause.inheritedTypes.count, 2)
        assertElementText(`class`.typeInheritanceClause.inheritedTypes[0], "Nested.Type")
        assertElementText(`class`.typeInheritanceClause.inheritedTypes[1], "Deep.Nested.Type")
    }

    func test_parse_shouldParseInheritanceTypeAsError_whenTypeIsMissing() throws {
        let text = "class A: {}"
        let `class` = try parse(text)
        XCTAssertEqual(`class`.typeInheritanceClause.inheritedTypes.count, 0)
        assertElementText(`class`, text)
    }

    func test_parse_shouldParseClassWithoutName() throws {
        let text = "class {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "")
    }

    func test_parse_shouldParseComplicatedClass() throws {
        let text = "@objc(NSMyClass) @abc fileprivate class MyClass : InheritedType1, Deep.Nested.T where T : A & B , Type2 == N.T {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "MyClass")
    }

    func test_parse_shouldParseClassWithKeywordName() throws {
        let text = "class weak {}"
        let `class` = try parse(text)
        assertElementText(`class`, text)
        XCTAssertEqual(`class`.name, "weak")
    }

    // MARK: - Helpers

    private func parse(_ text: String) throws -> ClassDeclaration {
        let parser = createParser(text, ClassDeclarationParser.self)
        return try parser.parse()
    }
}
