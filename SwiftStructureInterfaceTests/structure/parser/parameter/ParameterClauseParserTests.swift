import XCTest
@testable import SwiftStructureInterface

class ParameterClauseParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyParameterClause() {
        let clause = parse("()")
        XCTAssertEqual(clause.parameters.count, 0)
        XCTAssertEqual(clause.text, "()")
    }

    func test_parse_shouldParseSingleParameterClause() {
        let text = "(a: A)"
        let clause = parse(text)
        let parameter = clause.parameters[0]
        XCTAssertEqual(clause.text, text)
        assertElementText(parameter, "a: A", offset: 1)
    }

    func test_parse_shouldParseMultipleParameterClause() {
        let text = "(a: A, b: B)"
        let clause = parse(text)
        var parameter = clause.parameters[0]
        XCTAssertEqual(clause.text, text)
        assertElementText(parameter, "a: A", offset: 1)
        parameter = clause.parameters[1]
        assertElementText(parameter, "b: B", offset: 7)
    }

    func test_parse_shouldParseParameterClauseWithoutEndBracket() {
        let text = "(a: A"
        let clause = parse(text)
        let parameter = clause.parameters[0]
        XCTAssertEqual(clause.text, text)
        assertElementText(parameter, "a: A", offset: 1)
    }

    func test_parse_shouldParseParameterClauseWithoutStartBracket() {
        let text = "a: A)"
        let clause = parse(text)
        let parameter = clause.parameters[0]
        XCTAssertEqual(clause.text, text)
        assertElementText(parameter, "a: A")
    }

    func test_parse_shouldParseParameterClauseWithWhitespace() {
        let text = "( a : A , b : B )"
        XCTAssertEqual(parse(text).text, text)
    }

    func test_parse_shouldParseEmptyParameterClauseWithWhitespace() {
        XCTAssertEqual(parse("( )").text, "( )")
    }

    func test_parse_shouldParseParameterClauseWithMinimumWhitespace() {
        let text = "(a:A,b:B)"
        XCTAssertEqual(parse(text).text, text)
    }

    private func parse(_ input: String) -> ParameterClause {
        return createParser(input, ParameterClauseParser.self).parse()
    }
}
