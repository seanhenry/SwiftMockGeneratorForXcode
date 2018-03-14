import XCTest
@testable import SwiftStructureInterface

class FunctionDeclarationParameterClauseParserTests: XCTestCase {

    var parser: Parser<[Parameter]>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseEmptyParameterClause() {
        let parser = createParser("()", FunctionDeclarationParser.ParameterClauseParser.self)
        let clause = parser.parse()
        XCTAssertEqual(clause.count, 0)
    }

    func test_parse_shouldParseSingleParameterClause() {
        let parser = createParser("(a: A)", FunctionDeclarationParser.ParameterClauseParser.self)
        let clause = parser.parse()
        let parameter = clause[0]
        assertElementText(parameter, "a: A", offset: 1)
    }

    func test_parse_shouldParseMultipleParameterClause() {
        let parser = createParser("(a: A, b: B)", FunctionDeclarationParser.ParameterClauseParser.self)
        let clause = parser.parse()
        var parameter = clause[0]
        assertElementText(parameter, "a: A", offset: 1)
        parameter = clause[1]
        assertElementText(parameter, "b: B", offset: 7)
    }

    func test_parse_shouldParseParameterClauseWithoutEndBracket() {
        let parser = createParser("(a: A", FunctionDeclarationParser.ParameterClauseParser.self)
        let clause = parser.parse()
        let parameter = clause[0]
        assertElementText(parameter, "a: A", offset: 1)
    }

    func test_parse_shouldParseParameterClauseWithoutStartBracket() {
        let parser = createParser("a: A)", FunctionDeclarationParser.ParameterClauseParser.self)
        let clause = parser.parse()
        let parameter = clause[0]
        assertElementText(parameter, "a: A")
    }
}
