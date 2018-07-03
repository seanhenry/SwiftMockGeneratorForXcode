import XCTest
@testable import SwiftStructureInterface

class FindElementIndentTests: XCTestCase {

    func test_shouldFindElementIndentWhenNoIndent() throws {
        let element = try parse("class A {}").typeDeclarations[0]
        XCTAssertEqual(FindElementIndent().find(element), "")
    }

    func test_shouldFindElementIndentWhenSpacesIndent() throws {
        let element = try parse("  class A {}").typeDeclarations[0]
        XCTAssertEqual(FindElementIndent().find(element), "  ")
    }

    func test_shouldFindElementIndentWhenSpacesAndTabsIndent() throws {
        let element = try parse(" \tclass A {}").typeDeclarations[0]
        XCTAssertEqual(FindElementIndent().find(element), " \t")
    }

    func test_shouldFindElementIndentWhenImmediatelyAfterNewline() throws {
        let element = try parse("\nclass A {}").typeDeclarations[0]
        XCTAssertEqual(FindElementIndent().find(element), "")
    }

    func test_shouldFindIndentWhenSiblingsAreBetweenTheTargetAndTheStartOfLine() throws {
        let element = try parse("  class A: B {}")
                .typeDeclarations[0]
                .typeInheritanceClause
        XCTAssertEqual(FindElementIndent().find(element), "  ")
    }

    func test_shouldFindNestedElementIndent() throws {
        let file = """
        class A {
          class B {
          }
        }
        """
        let element = try parse(file)
                .typeDeclarations[0]
                .typeDeclarations[0]
        XCTAssertEqual(FindElementIndent().find(element), "  ")
    }

    func test_shouldFindElementIndentWhenContainedInManyParents() throws {
        let file = """
          class A { class B { class C {} } }
        """
        let element = try parse(file)
                .typeDeclarations[0]
                .typeDeclarations[0]
                .typeDeclarations[0]
        XCTAssertEqual(FindElementIndent().find(element), "  ")
    }

    private func parse(_ input: String) throws -> File {
        return try ParserTestHelper.parseFile(from: input)
    }
}
