import XCTest
@testable import SwiftStructureInterface

class ParameterClauseParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyParameterClause() throws {
        let clause = try parse("()")
        XCTAssertEqual(clause.parameters.count, 0)
        XCTAssertEqual(clause.text, "()")
    }

    func test_parse_shouldParseSingleParameterClause() throws {
        let text = "(a: A)"
        let clause = try parse(text)
        let parameter = clause.parameters[0]
        XCTAssertEqual(clause.text, text)
        assertElementText(parameter, "a: A", offset: 1)
    }

    func test_parse_shouldParseMultipleParameterClause() throws {
        let text = "(a: A, b: B)"
        let clause = try parse(text)
        var parameter = clause.parameters[0]
        XCTAssertEqual(clause.text, text)
        assertElementText(parameter, "a: A", offset: 1)
        parameter = clause.parameters[1]
        assertElementText(parameter, "b: B", offset: 7)
    }

    func test_parse_shouldParseParameterClauseWithoutEndBracket() throws {
        let text = "(a: A"
        let clause = try parse(text)
        let parameter = clause.parameters[0]
        XCTAssertEqual(clause.text, text)
        assertElementText(parameter, "a: A", offset: 1)
    }

    func test_parse_shouldParseParameterClauseWithWhitespace() throws {
        let text = "( a : A , b : B )"
        XCTAssertEqual(try parse(text).text, text)
    }

    func test_parse_shouldParseEmptyParameterClauseWithWhitespace() throws {
        XCTAssertEqual(try parse("( )").text, "( )")
    }

    func test_parse_shouldParseParameterClauseWithMinimumWhitespace() throws {
        let text = "(a:A,b:B)"
        XCTAssertEqual(try parse(text).text, text)
    }

    func test_parse_shouldNotParseClauseWhenDoesNotStartWithLeftParen() throws {
        XCTAssertThrowsError(try parse("a:A)"))
    }

    private func parse(_ input: String) throws -> ParameterClause {
        return try createParser(input, ParameterClauseParser.self).parse()
    }
}
