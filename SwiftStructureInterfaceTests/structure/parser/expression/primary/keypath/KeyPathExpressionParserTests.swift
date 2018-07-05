import XCTest
@testable import SwiftStructureInterface

class KeyPathExpressionParserTests: XCTestCase {

    func test_shouldParseExpression() throws {
        let text = "\\AType.path"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseKeywordTypeAndComponent() throws {
        let text = "\\convenience.associativity"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseLongExpression() throws {
        let text = "\\AType.path.to.item"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionWithOptionalPostfix() throws {
        let text = "\\AType.path?"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionWithIUOPostfix() throws {
        let text = "\\AType.path!"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionWithFunctionCallList() throws {
        let text = "\\AType.path[_:expression]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseWhenNoBackslash() {
        XCTAssertThrowsError(try parse("AType"))
    }

    func test_shouldCorrectlyParseTree() throws {
        let text = "\\AType.path?.to!.item[expression]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssertEqual(expression.type?.text, "AType")
        XCTAssertEqual(expression.components.components.count, 3)
        XCTAssertEqual(expression.components.components[0].text, "path?")
        XCTAssertEqual(expression.components.components[1].text, "to!")
        XCTAssertEqual(expression.components.components[2].text, "item[expression]")
        XCTAssertEqual(expression.components.components[0].identifier?.text, "path")
        XCTAssertEqual(expression.components.components[0].postfixes?.postfixes[0].text, "?")
        XCTAssertEqual(expression.components.components[1].identifier?.text, "to")
        XCTAssertEqual(expression.components.components[1].postfixes?.postfixes[0].text, "!")
        XCTAssertEqual(expression.components.components[2].identifier?.text, "item")
        XCTAssertEqual(expression.components.components[2].postfixes?.postfixes[0].text, "[expression]")

    }

    func test_shouldParseExpressionWithImplicitType() throws {
        let text = "\\.path"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseExpressionWithOnlyPostfixes() throws {
        let text = "\\AType.?![++]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseFunctionCallListWhenMissingRightSquare() throws {
        let text = "\\AType.[+"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseFunctionCallListWhenNoFunctionItems() throws {
        let text = "\\AType.[]"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    private func parse(_ input: String) throws -> KeyPathExpression {
        return try createParser(input, KeyPathExpressionParser.self).parse()
    }
}
