import XCTest
@testable import SwiftStructureInterface

class WhitespaceParserTests: XCTestCase {

    var parser: Parser<File>!

    func test_shouldCalculateSingleWhitespace() {
        createFileParser("func a()")
        parseKeyword()
        XCTAssertEqual(parseWhitespace().text, " ")
    }

    func test_shouldCalculateNewline() {
        createFileParser("func\na()")
        parseKeyword()
        XCTAssertEqual(parseWhitespace().text, "\n")
    }

    // TODO: lexer does not support \r on its own

    func test_shouldCalculateCarriageReturn() {
        createFileParser("func\r\na()")
        parseKeyword()
        XCTAssertEqual(parseWhitespace().text, "\r")
        XCTAssertEqual(parser.peekAtNextIdentifier(), "a")
    }

    func test_shouldCalculateDoubleWhitespace() {
        createFileParser("func  a()")
        parseKeyword()
        XCTAssertEqual(parseWhitespace().text, "  ")
    }

    func test_shouldCalculateTab() {
        createFileParser("func\ta()")
        parseKeyword()
        XCTAssertEqual(parseWhitespace().text, "\t")
    }

    func test_shouldCalculateMixedWhitespace() {
        createFileParser("func \t\n\r\na()")
        parseKeyword()
        XCTAssertEqual(parseWhitespace().text, " \t\n\r")
    }

    func test_shouldCalculateWhitespaceAtBeginningOfFile() {
        createFileParser(" func a()")
        XCTAssertEqual(parseWhitespace().text, " ")
        XCTAssertEqual(parseKeyword()?.text, "func")
    }

    func test_shouldCalculateWhitespaceAtEndOfFile() {
        createFileParser("func ")
        parseKeyword()
        XCTAssertEqual(parseWhitespace().text, " ")
    }

    func test_shouldThrowWhenParsingZeroWhitespaceAtStartOfFile() {
        createFileParser("func a")
        XCTAssertThrowsError(try parseEmptyWhitespace())
    }

    func test_shouldNotParseEmptyWhitespace() {
        createFileParser("")
        XCTAssertThrowsError(try parseEmptyWhitespace())
    }

    // MARK: - Helpers

    private func createFileParser(_ input: String) {
        parser = createParser(input, FileParser.self)
    }

    @discardableResult
    private func parseKeyword() -> Element? {
        return try? parser.parseKeyword()
    }

    private func parseWhitespace() -> Element {
        return try! parser.parseWhitespace()
    }

    private func parseEmptyWhitespace() throws -> Element {
        return try parser.parseWhitespace()
    }
}
