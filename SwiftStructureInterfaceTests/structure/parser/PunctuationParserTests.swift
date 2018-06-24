import XCTest
@testable import SwiftStructureInterface

class PunctuationParserTests: XCTestCase {

    func test_parsePunctuation() {
        XCTAssertEqual(parse("->").text, "->")
        XCTAssertEqual(parse(":").text, ":")
        XCTAssertEqual(parse(",").text, ",")
        XCTAssertEqual(parse(".").text, ".")
        XCTAssertEqual(parse(";").text, ";")
        XCTAssertEqual(parse("@").text, "@")
        XCTAssertEqual(parse("#").text, "#")
        XCTAssertEqual(parse("\\").text, "\\")
        XCTAssertEqual(parse("(").text, "(")
        XCTAssertEqual(parse(")").text, ")")
        XCTAssertEqual(parse("{").text, "{")
        XCTAssertEqual(parse("}").text, "}")
        XCTAssertEqual(parse("[").text, "[")
        XCTAssertEqual(parse("]").text, "]")
        XCTAssertEqual(parse("<").text, "<")
        XCTAssertEqual(parse("&").text, "&")
        XCTAssertEqual(parse("_").text, "_")
    }

    func test_parseInvalid() {
        XCTAssertEqual(parse("").text, "")
        XCTAssertEqual(parse("+").text, "")
    }

    func test_parseRightChevron() {
        let parser = createParser("<T>", PunctuationParser.self)
        try! parser.parsePunctuation(.leftChevron)
        parser.parseType()
        XCTAssertEqual(try parser.parsePunctuation(.rightChevron).text, ">")
    }

    // MARK: - Helpers

    func parse(_ input: String) -> LeafNode {
        return createParser(input, PunctuationParser.self).parse()
    }
}
