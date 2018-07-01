import XCTest
@testable import SwiftStructureInterface

class TupleExpressionParserTests: XCTestCase {

    func test_shouldParseEmptyExpression() throws {
        let text = "()"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseMissingOpeningParen() {
        XCTAssertThrowsError(try parse(")"))
    }

    func test_shouldParseMissingOpeningParen() throws {
        let text = "("
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseTupleWithElement() throws {
        let text = "(expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseTupleWithElements() throws {
        let text = "(expression, expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseTupleWithNamedElement() throws {
        let text = "(name: expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseTupleWithNamedElements() throws {
        let text = "(name: expression, name: expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseTupleTree() throws {
        let text = "(expression, name: expression)"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssertEqual(expression.tupleElementList.text, "expression, name: expression")
        XCTAssertEqual(expression.tupleElementList.elements.count, 2)
        XCTAssertEqual(expression.tupleElementList.elements[0].text, "expression")
        XCTAssertEqual(expression.tupleElementList.elements[1].text, "name: expression")
    }

    private func parse(_ input: String) throws -> TupleExpression {
        return try createParser(input, TupleExpressionParser.self).parse()
    }
}
