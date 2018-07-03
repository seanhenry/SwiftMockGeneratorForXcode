import XCTest
@testable import SwiftStructureInterface

class FindElementLocationTests: XCTestCase {

    // MARK: - LineColumn

    func test_shouldFindLineColumnOfElementAtStartOfFile() throws {
        let element = try parse("class A {}").typeDeclarations[0]
        let (line, column) = FindElementLocation().findLineColumn(element)
        XCTAssertEqual(line, 0)
        XCTAssertEqual(column, 0)
    }

    func test_shouldFindLineColumnOfElementInMiddleOfColumn() throws {
        let element = try parse("class A: B {}")
                .typeDeclarations[0]
                .typeInheritanceClause
        let (line, column) = FindElementLocation().findLineColumn(element)
        XCTAssertEqual(line, 0)
        XCTAssertEqual(column, 7)
    }

    func test_shouldFindLineColumnOfElementInEndOfColumn() throws {
        let element = try parse("class A: B\n{}")
                .typeDeclarations[0]
                .typeInheritanceClause
                .inheritedTypes[0]
        let (line, column) = FindElementLocation().findLineColumn(element)
        XCTAssertEqual(line, 0)
        XCTAssertEqual(column, 9)
    }

    func test_shouldFindLineColumnOfElementInMiddleLine() throws {
        let file = """
        class A {}
        class B {}
        class C {}
        """
        let element = try parse(file).typeDeclarations[1]
        let (line, column) = FindElementLocation().findLineColumn(element)
        XCTAssertEqual(line, 1)
        XCTAssertEqual(column, 0)
    }

    func test_shouldFindLineColumnOfElementAtEndOfMiddleLine() throws {
        let file = """
        class A {}
        class B: C
        {}
        class D {}
        """
        let element = try parse(file)
                .typeDeclarations[1]
                .typeInheritanceClause
                .inheritedTypes[0]
        let (line, column) = FindElementLocation().findLineColumn(element)
        XCTAssertEqual(line, 1)
        XCTAssertEqual(column, 9)
    }

    func test_shouldFindLineColumnOfElementAtEndOfListLine() throws {
        let file = """
        class A {}
        class B {}
        class C {}
        """
        let element = try parse(file)
                .typeDeclarations[2]
                .codeBlock
                .children.last!
        let (line, column) = FindElementLocation().findLineColumn(element)
        XCTAssertEqual(line, 2)
        XCTAssertEqual(column, 10)
    }

    // MARK: - Offset

    func test_shouldFindOffsetOfElementAtStartOfFile() throws {
        let element = try parse("class A {}").typeDeclarations[0]
        let offset = FindElementLocation().findOffset(element)
        XCTAssertEqual(offset, 0)
    }

    func test_shouldFindOffsetOfElementInMiddleOfColumn() throws {
        let element = try parse("class A: B {}")
                .typeDeclarations[0]
                .typeInheritanceClause
        let offset = FindElementLocation().findOffset(element)
        XCTAssertEqual(offset, 7)
    }

    func test_shouldFindOffsetOfElementInEndOfColumn() throws {
        let element = try parse("class A: B\n{}")
                .typeDeclarations[0]
                .typeInheritanceClause
                .inheritedTypes[0]
        let offset = FindElementLocation().findOffset(element)
        XCTAssertEqual(offset, 9)
    }

    func test_shouldAcceptCarriageReturn() throws {
        let element = try parse("class A: B\r\n{}")
                .typeDeclarations[0]
                .codeBlock
        let (line, column, offset) = FindElementLocation().findLineColumnOffset(element)
        XCTAssertEqual(line, 1)
        XCTAssertEqual(column, 0)
        XCTAssertEqual(offset, 11)
    }

    func test_shouldFindOffsetOfElementInMiddleLine() throws {
        let file = """
        class A {}
        class B {}
        class C {}
        """
        let element = try parse(file).typeDeclarations[1]
        let offset = FindElementLocation().findOffset(element)
        XCTAssertEqual(offset, 11)
    }

    func test_shouldFindOffsetOfElementAtEndOfMiddleLine() throws {
        let file = """
        class A {}
        class B: C
        {}
        class D {}
        """
        let element = try parse(file)
                .typeDeclarations[1]
                .typeInheritanceClause
                .inheritedTypes[0]
        let offset = FindElementLocation().findOffset(element)
        XCTAssertEqual(offset, 20)
    }

    func test_shouldFindOffsetOfElementAtEndOfListLine() throws {
        let file = """
        class A {}
        class B {}
        class C {}
        """
        let element = try parse(file)
                .typeDeclarations[2]
                .codeBlock
                .children.last!
        let offset = FindElementLocation().findOffset(element)
        XCTAssertEqual(offset, 32)
    }

    private func parse(_ input: String) throws -> File {
        return try ParserTestHelper.parseFile(from: input)
    }
}
