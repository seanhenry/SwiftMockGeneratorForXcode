import XCTest
@testable import SwiftStructureInterface

class PunctuationParserTests: XCTestCase {

    func test_parsePunctuation() {
        XCTAssertEqual(try parse("->").text, "->")
        XCTAssertEqual(try parse(":").text, ":")
        XCTAssertEqual(try parse(",").text, ",")
        XCTAssertEqual(try parse(".").text, ".")
        XCTAssertEqual(try parse(";").text, ";")
        XCTAssertEqual(try parse("@").text, "@")
        XCTAssertEqual(try parse("#").text, "#")
        XCTAssertEqual(try parse("\\").text, "\\")
        XCTAssertEqual(try parse("(").text, "(")
        XCTAssertEqual(try parse(")").text, ")")
        XCTAssertEqual(try parse("{").text, "{")
        XCTAssertEqual(try parse("}").text, "}")
        XCTAssertEqual(try parse("[").text, "[")
        XCTAssertEqual(try parse("]").text, "]")
        XCTAssertEqual(try parse("<").text, "<")
        XCTAssertEqual(try parse("&").text, "&")
        XCTAssertEqual(try parse("_").text, "_")
    }

    func test_parseInvalid() {
        XCTAssertEqual(try parse("").text, "")
        XCTAssertEqual(try parse("+").text, "")
    }

    func test_parseRightChevron() {
        let parser = createParser("<T>", PunctuationParser.self)
        _ = try! parser.parsePunctuation(.leftChevron)
        _ = try! parser.parseType()
        XCTAssertEqual(try parser.parsePunctuation(.rightChevron).text, ">")
    }

    // MARK: - Helpers

    func parse(_ input: String) throws -> LeafNode {
        return try createParser(input, PunctuationParser.self).parse()
    }
}
