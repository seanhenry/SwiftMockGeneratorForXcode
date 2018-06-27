import XCTest
@testable import SwiftStructureInterface

class ParseBuilderTests: XCTestCase {

    var parser: Parser<File>!

    func test_shouldBuildRequiredItem() {
        let children = try! builder("var a : A")
                .required { try self.parser.parseKeyword() }
                .build()
        XCTAssertEqual(children.count, 1)
        XCTAssertEqual(children[0].text, "var")
    }

    func test_shouldBuildWhitespaceBetweenItemsOnly() {
        let children = try! builder("var a : A")
                .required { try self.parser.parseKeyword() }
                .required { try self.parser.parseIdentifier() }
                .build()
        XCTAssertEqual(children.count, 3)
        XCTAssertEqual(children[0].text, "var")
        XCTAssertEqual(children[1].text, " ")
        XCTAssertEqual(children[2].text, "a")
    }

    func test_shouldThrowWhenRequiredItemCannotBeParsed() {
        XCTAssertThrowsError(try builder("").required { nil }.build())
    }

    func test_shouldBuildOptionalItems() {
        let children = try! builder("var a : A")
                .optional { try self.parser.parseKeyword() }
                .optional { try self.parser.parseIdentifier() }
                .build()
        XCTAssertEqual(children.count, 3)
        XCTAssertEqual(children[0].text, "var")
        XCTAssertEqual(children[1].text, " ")
        XCTAssertEqual(children[2].text, "a")
    }

    func test_shouldNotParseWhitespaceTwiceWhenOptionalReturnsNil() {
        let children = try! builder("var a : A")
                .optional { try self.parser.parseKeyword() }
                .optional { nil }
                .optional { try self.parser.parseIdentifier() }
                .build()
        XCTAssertEqual(children.count, 3)
        XCTAssertEqual(children[0].text, "var")
        XCTAssertEqual(children[1].text, " ")
        XCTAssertEqual(children[2].text, "a")
    }

    func test_shouldNotParseWhitespaceForLastNonNilOperation() {
        let children = try! builder("var a : A")
                .optional { try self.parser.parseKeyword() }
                .optional { try self.parser.parseIdentifier() }
                .optional { nil }
                .build()
        XCTAssertEqual(children.count, 3)
        XCTAssertEqual(children[0].text, "var")
        XCTAssertEqual(children[1].text, " ")
        XCTAssertEqual(children[2].text, "a")
    }

    func test_shouldNotParseWhitespaceBeforeFirstElement() {
        let children = try! builder(" var a : A")
                .optional { try self.parser.parseKeyword() }
                .build()
        XCTAssertEqual(children.count, 1)
        XCTAssertEqual(children[0].text, "var")
    }

    func test_shouldParseWhileFirstIsParsedForOneElement() {
        let children = try! builder(" , var ")
                .while(isParsed: { try self.parser.parsePunctuation(.comma) }) {
                    try self.parser.parseKeyword()
                }
                .build()
        XCTAssertEqual(children.count, 3)
        XCTAssertEqual(children[0].text, ",")
        XCTAssertEqual(children[1].text, " ")
        XCTAssertEqual(children[2].text, "var")
    }

    func test_shouldNotParseWhileFirstConditionCannotBeParsed() {
        let children = try! builder("var")
                .while(isParsed: { try self.parser.parsePunctuation(.comma) }) {
                    try self.parser.parseKeyword()
                }
                .build()
        XCTAssertEqual(children.count, 0)
    }

    func test_shouldContinueToParseWhenWhileLoopParsesEvenWhenOtherStatementsAreNotParsed() {
        let children = try! builder(",,,")
                .while(isParsed: { try self.parser.parsePunctuation(.comma) }) {
                    try self.parser.parseKeyword()
                }
                .build()
        XCTAssertEqual(children.count, 3)
        XCTAssertEqual(children[0].text, ",")
        XCTAssertEqual(children[1].text, ",")
        XCTAssertEqual(children[2].text, ",")
    }

    func test_shouldContinueToParseWhenWhileIsParsed() {
        let children = try! builder(", var , var a")
                .while(isParsed: { try self.parser.parsePunctuation(.comma) }) {
                    try self.parser.parseKeyword()
                }
                .optional { try self.parser.parseIdentifier() }
                .build()
        XCTAssertEqual(children.count, 9)
        XCTAssertEqual(children[0].text, ",")
        XCTAssertEqual(children[1].text, " ")
        XCTAssertEqual(children[2].text, "var")
        XCTAssertEqual(children[3].text, " ")
        XCTAssertEqual(children[4].text, ",")
        XCTAssertEqual(children[5].text, " ")
        XCTAssertEqual(children[6].text, "var")
        XCTAssertEqual(children[7].text, " ")
        XCTAssertEqual(children[8].text, "a")
    }

    func test_shouldSetCheckpoint() {
        let children = try? builder(" var a : A")
                .required { try self.parser.parseKeyword() }
                .required { try self.parser.parseKeyword() }
                .build()
        let nextTry = try! parser.builder()
                .required { try self.parser.parseKeyword() }
                .build()
        XCTAssertNil(children)
        XCTAssertEqual(nextTry[0].text, "var")
    }

    func test_shouldContinueParsingUntilThrows() throws {
        let children = try builder(",,,")
                .while { try self.parser.parsePunctuation(.comma) }
                .build()
        XCTAssertEqual(children.count, 3)
        XCTAssertEqual(children[0].text, ",")
        XCTAssertEqual(children[1].text, ",")
        XCTAssertEqual(children[2].text, ",")
    }

    private func builder(_ input: String) -> ParserBuilder {
        parser = createParser(input, FileParser.self)
        return parser.builder()
    }
}
