import XCTest
@testable import SwiftStructureInterface

class OperatorParserTests: XCTestCase {

    func test_shouldParsePrefixOperator() throws {
        let parser = getParser("+identifier")
        let op = try parser.parse()
        XCTAssertEqual(op.text, "+")
    }

    func test_shouldParsePostfixOperator() throws {
        let parser = getParser("identifier+")
        _ = try parser.parseStrictIdentifier()
        let op = try parser.parse()
        XCTAssertEqual(op.text, "+")
    }

    func test_shouldParseBinaryOperator() throws {
        let parser = getParser("identifier + identifier")
        _ = try parser.parseStrictIdentifier()
        let op = try parser.parse()
        XCTAssertEqual(op.text, "+")
    }

    func test_shouldParseAssignmentOperator() throws {
        let parser = getParser("identifier = identifier")
        _ = try parser.parseStrictIdentifier()
        let op = try parser.parse()
        XCTAssertEqual(op.text, "=")
    }

    private func getParser(_ input: String) -> OperatorParser {
        return createParser(input, OperatorParser.self)
    }
}
