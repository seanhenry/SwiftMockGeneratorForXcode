import XCTest
@testable import SwiftStructureInterface

class DefaultArgumentClauseParserTests: XCTestCase {

    func test_shouldParseClause() throws {
        let text = "= expression"
        let clause = try parse(text)
        XCTAssertEqual(clause.text, text)
    }

    func test_shouldNotParseWhenNoAssignmentOperator() {
        XCTAssertThrowsError(try parse("expression"))
    }

    func test_shouldParseWhenNoExpressionAndAnotherParameter() throws {
        let clause = try parse("= ,")
        XCTAssertEqual(clause.text, "=")
    }

    func test_shouldParseWhenNoExpressionAtTheEndOfTheParameterClause() throws {
        let clause = try parse("= )")
        XCTAssertEqual(clause.text, "=")
    }

    func test_shouldParseAsPartOfParameter() throws {
        let parser = createParser("a: Int = 0", DefaultArgumentClauseParser.self)
        _ = try parser.parseIdentifier()
        _ = try parser.parsePunctuation(.colon)
        _ = try parser.parseType()
        XCTAssertEqual(try parser.parse().text, "= 0")
    }

    func test_shouldParseTree() throws {
        let text = "= MyClass.myMethod()"
        let clause = try parse(text)
        XCTAssertEqual(clause.text, text)
        XCTAssertEqual(clause.expression.text, "MyClass.myMethod()")
    }

    private func parse(_ input: String) throws -> DefaultArgumentClause {
        return try createParser(input, DefaultArgumentClauseParser.self).parse()
    }
}
