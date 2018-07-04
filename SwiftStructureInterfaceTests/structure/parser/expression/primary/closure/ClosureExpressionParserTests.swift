import XCTest
@testable import SwiftStructureInterface

class ClosureExpressionParserTests: XCTestCase {

    func test_shouldParseEmptyClosure() throws {
        let text = "{}"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseClosureMissingLeftBrace() {
        XCTAssertThrowsError(try parse("}"))
    }

    func test_shouldParseClosureWithoutTrailingBrace() throws {
        let text = "{"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    // MARK: - CaptureList

    func test_shouldParseClosureWithCaptureList() throws {
        let text = "{ [expression] in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldNotParseCaptureListWhenMissingLeadingSquare() throws {
        let text = "{ expression] in }"
        let expression = try parse(text)
        XCTAssertNil(expression.closureSignature?.captureList)
    }

    func test_shouldParseCaptureListWhenMissingTrailingSquare() throws {
        let text = "{ [expression in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseCaptureListWhenMissingExpression() throws {
        let text = "{ [] in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseCaptureListWithSpecifiers() throws {
        let specifiers = ["unowned", "weak", "unowned(safe)", "unowned(unsafe)"]
        try specifiers.forEach { specifier in
            let text = "{ [\(specifier) expression] in }"
            let expression = try parse(text)
            XCTAssertEqual(expression.text, text)
        }
    }

    func test_shouldNotParseCaptureListWhenSpecifierIsAlone() throws {
        let text = "{ [weak] in }"
        let expression = try parse(text)
        XCTAssertNil(expression.closureSignature?.captureList)
    }

    func test_shouldParseCaptureListTree() throws {
        let text = "{ [weak expression] in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssertEqual(expression.closureSignature?.text, "[weak expression] in")
        XCTAssertEqual(expression.closureSignature?.captureList?.text, "[weak expression]")
        XCTAssertEqual(expression.closureSignature?.captureList?.captureListItems.text, "weak expression")
        XCTAssertEqual(expression.closureSignature?.captureList?.captureListItems.items[0].expression.text, "expression")
    }

    func test_shouldNotParseCaptureListMissingInKeyword() throws {
        let expression = try parse("{ [expression] }")
        XCTAssertNil(expression.closureSignature?.captureList)
    }

    func test_shouldParseClosureWithManyCaptureListItems() throws {
        let text = "{ [expression, unowned(unsafe) self] in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    // MARK: - ClosureParameterClause

    func test_shouldParseEmptyClosureParameterClause() throws {
        let text = "{ () in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseClosureParameterClauseWithIdentifierOnly() throws {
        let text = "{ (identifier) in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseClosureParameterClauseWithIdentifierAndTypeAnnotation() throws {
        let text = "{ (identifier: T) in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseClosureParameterClauseWithVarArgs() throws {
        let text = "{ (identifier: T...) in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseClosureParameterClauseWithManyItems() throws {
        let text = "{ (identifier, identifier2: T...) in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseClosureParameterClauseWithSingleIdentifier() throws {
        let text = "{ identifier in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseClosureParameterClauseWithIdentifierList() throws {
        let text = "{ identifier, identifier2 in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseThrowingClosureParameterClause() throws {
        let text = "{ (identifier) throws in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseClosureParameterClauseWithReturnType() throws {
        let text = "{ (identifier) -> ReturnType in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    func test_shouldParseClosureParameterClauseTree() throws {
        let text = "{ (identifier: T) throws -> [Int] in }"
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
        XCTAssertEqual(expression.closureSignature?.closureParameterClause.text, "(identifier: T)", text)
        XCTAssertEqual(expression.closureSignature?.closureParameterClause.closureParameterList?.text, "identifier: T", text)
        XCTAssertEqual(expression.closureSignature?.closureParameterClause.closureParameterList?.closureParameters[0].text, "identifier: T", text)
        XCTAssertEqual(expression.closureSignature?.functionResult?.text, "-> [Int]", text)
    }

    // MARK: - Statements

    func test_shouldParseClosureWithStatements() throws {
        let text = """
        {
        var a: A
        self.expression()
        }
        """
        let expression = try parse(text)
        XCTAssertEqual(expression.text, text)
    }

    private func parse(_ input: String) throws -> ClosureExpression {
        return try createParser(input, ClosureExpressionParser.self).parse()
    }
}
