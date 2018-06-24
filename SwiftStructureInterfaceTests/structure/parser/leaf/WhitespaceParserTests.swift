import XCTest
@testable import SwiftStructureInterface

class WhitespaceParserTests: XCTestCase {

    func test_shouldCalculateSingleWhitespace() {
        let parser = createFileParser("func a()")
        _ = parser.parseKeyword()
        XCTAssertEqual(parser.parseWhitespace().text, " ")
    }

    func test_shouldCalculateNewline() {
        let parser = createFileParser("func\na()")
        _ = parser.parseKeyword()
        XCTAssertEqual(parser.parseWhitespace().text, "\n")
    }

    // TODO: lexer does not support \r on its own

    func test_shouldCalculateCarriageReturn() {
        let parser = createFileParser("func\r\na()")
        _ = parser.parseKeyword()
        XCTAssertEqual(parser.parseWhitespace().text, "\r")
        XCTAssertEqual(parser.peekAtNextIdentifier(), "a")
    }

    func test_shouldCalculateDoubleWhitespace() {
        let parser = createFileParser("func  a()")
        _ = parser.parseKeyword()
        XCTAssertEqual(parser.parseWhitespace().text, "  ")
    }

    func test_shouldCalculateTab() {
        let parser = createFileParser("func\ta()")
        _ = parser.parseKeyword()
        XCTAssertEqual(parser.parseWhitespace().text, "\t")
    }

    func test_shouldCalculateMixedWhitespace() {
        let parser = createFileParser("func \t\n\r\na()")
        _ = parser.parseKeyword()
        XCTAssertEqual(parser.parseWhitespace().text, " \t\n\r")
    }

    func test_shouldCalculateWhitespaceAtBeginningOfFile() {
        let parser = createFileParser(" func a()")
        XCTAssertEqual(parser.parseWhitespace().text, " ")
        XCTAssertEqual(parser.parseKeyword().text, "func")
    }

    func test_shouldCalculateWhitespaceAtEndOfFile() {
        let parser = createFileParser("func ")
        _ = parser.parseKeyword()
        XCTAssertEqual(parser.parseWhitespace().text, " ")
    }

    // MARK: - Helpers

    private func parse(_ input: String) -> Whitespace {
        return createParser(input, WhitespaceParser.self).parse()
    }

    private func createFileParser(_ input: String) -> Parser<File> {
        return createParser(input, FileParser.self)
    }
}
