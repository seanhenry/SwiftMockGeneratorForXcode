import XCTest
@testable import SwiftStructureInterface

class TypeInheritanceClauseParserTests: XCTestCase {

    func test_shouldNotParseClauseWithoutColon() {
        XCTAssertThrowsError(try parse("T"))
    }

    func test_shouldParseEmptyClause() {
        XCTAssertEqual(try parse(": ").text, ":")
    }

    func test_shouldParseSingleInheritanceClause() throws {
        let clause = try parse(": A")
        XCTAssertEqual(clause.text, ": A")
        XCTAssertEqual(clause.inheritedTypes.count, 1)
        XCTAssertEqual(clause.inheritedTypes[0].text, "A")
    }

    func test_shouldParseManyInheritanceClauseItems() throws {
        let clause = try parse(": A, B, C")
        XCTAssertEqual(clause.text, ": A, B, C")
        XCTAssertEqual(clause.inheritedTypes.count, 3)
        XCTAssertEqual(clause.inheritedTypes[0].text, "A")
        XCTAssertEqual(clause.inheritedTypes[1].text, "B")
        XCTAssertEqual(clause.inheritedTypes[2].text, "C")
    }

    func test_shouldNotParseWhereClause() throws {
        let clause = try parse(": A, where")
        XCTAssertEqual(clause.text, ": A,")
    }

    private func parse(_ input: String) throws -> TypeInheritanceClause {
        return try createParser(input, TypeInheritanceClauseParser.self).parse()
    }
}
