import XCTest
@testable import SwiftStructureInterface

class SuperclassExpressionParserTests: XCTestCase {

    func test_shouldNotParseSuperOnItsOwn() throws {
        XCTAssertThrowsError(try parse("super"))
    }

    func test_shouldParseSuperMethodExpression() throws {
        let text = "super.identifier"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is SuperclassMethodExpression)
    }

    func test_shouldParseSuperMethodExpressionWithKeywordIdentifier() throws {
        let text = "super.didSet"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is SuperclassMethodExpression)
    }

    func test_shouldParseSuperInitializerExpression() throws {
        let text = "super.init"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is SuperclassInitializerExpression)
    }

    func test_shouldParseSuperclassSubscriptExpression() throws {
        let text = "super[a: expr, ++]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is SuperclassSubscriptExpression)
    }

    func test_shouldNotParseSubscriptWhenMissingLeadingSquare() {
        XCTAssertThrowsError(try parse("super expr]"))
    }

    func test_shouldParseSuperclassSubscriptExpressionMissingClosingSquare() throws {
        let text = "super[a: expr"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is SuperclassSubscriptExpression)
    }

    func test_shouldParseSuperclassSubscriptExpressionMissingFunctionCallList() throws {
        let text = "super[]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssert(expression is SuperclassSubscriptExpression)
    }

    private func parse(_ input: String) throws -> SuperclassExpression {
        return try createParser(input, SuperclassExpressionParser.self).parse()
    }
}
