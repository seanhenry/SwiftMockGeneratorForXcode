import XCTest
@testable import SwiftStructureInterface

class ParseBuilderTests: XCTestCase {

    var parser: Parser<File>!
    struct TestError: Error {}

    override func tearDown() {
        parser = nil
        super.tearDown()
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

    // MARK: - require

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

    func test_shouldThrowWhenRequiredItemCannotBeParsed() throws {
        XCTAssertThrowsError(try builder("").required { throw TestError() }.build())
    }

    // MARK: - optional

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

    func test_shouldNotParseWhitespaceTwiceWhenOptionalFails() {
        let children = try! builder("var a : A")
                .optional { try self.parser.parseKeyword() }
                .optional { throw TestError() }
                .optional { try self.parser.parseIdentifier() }
                .build()
        XCTAssertEqual(children.count, 3)
        XCTAssertEqual(children[0].text, "var")
        XCTAssertEqual(children[1].text, " ")
        XCTAssertEqual(children[2].text, "a")
    }

    func test_shouldNotParseWhitespaceForLastSuccessfulOperation() {
        let children = try! builder("var a : A")
                .optional { try self.parser.parseKeyword() }
                .optional { try self.parser.parseIdentifier() }
                .optional { throw TestError() }
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

    // MARK: - while(do:)

    func test_shouldContinueParsingUntilElementIsNil() {
        let children = try! builder("public final class")
                .while { try self.parser.parseDeclarationModifier() }
                .build()
        XCTAssertEqual(children.count, 5)
        XCTAssertEqual(children[0].text, "public")
        XCTAssertEqual(children[1].text, " ")
        XCTAssertEqual(children[2].text, "final")
        XCTAssertEqual(children[3].text, " ")
        XCTAssertEqual(children[4].text, "class")
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

    // MARK: - while

    func test_shouldContinueParsingUntilThrows() throws {
        let children = try builder(",,,")
                .while { try self.parser.parsePunctuation(.comma) }
                .build()
        XCTAssertEqual(children.count, 3)
        XCTAssertEqual(children[0].text, ",")
        XCTAssertEqual(children[1].text, ",")
        XCTAssertEqual(children[2].text, ",")
    }

    func test_shouldContinueParsingUntilThrowsAndParseWhitespace() throws {
        let children = try builder(" , , , ")
                .while { try self.parser.parsePunctuation(.comma) }
                .build()
        XCTAssertEqual(children.count, 5)
        XCTAssertEqual(children[0].text, ",")
        XCTAssertEqual(children[1].text, " ")
        XCTAssertEqual(children[2].text, ",")
        XCTAssertEqual(children[3].text, " ")
        XCTAssertEqual(children[4].text, ",")
    }

    // MARK: - either

    func test_either_shouldParseLhsIfExistsAndShouldNotParseRightHandSide() throws {
        let children = try builder(":,")
                .either({ try self.parser.parsePunctuation(.colon) }) {
                    try self.parser.parsePunctuation(.comma)
                }
                .build()
        XCTAssertEqual(children.count, 1)
        XCTAssertEqual(children[0].text, ":")
    }

    func test_either_shouldParseRhsWhenLhsCannotBeParsed() throws {
        let children = try builder(",:")
                .either({ try self.parser.parsePunctuation(.colon) }) {
                    try self.parser.parsePunctuation(.comma)
                }
                .build()
        XCTAssertEqual(children.count, 1)
        XCTAssertEqual(children[0].text, ",")
    }

    func test_either_shouldNotThrowWhenNethierAreParsed() throws {
        let children = try builder(",:")
                .either({ try self.parser.parsePunctuation(.colon) }) {
                    try self.parser.parsePunctuation(.comma)
                }
                .build()
        XCTAssertEqual(children.count, 1)
        XCTAssertEqual(children[0].text, ",")
    }

    // MARK: - requireEither

    func test_requireEither_shouldParseLhsIfExistsAndShouldNotParseRightHandSide() throws {
        let children = try builder(":,")
                .requireEither({ try self.parser.parsePunctuation(.colon) }) {
                    try self.parser.parsePunctuation(.comma)
                }
                .build()
        XCTAssertEqual(children.count, 1)
        XCTAssertEqual(children[0].text, ":")
    }

    func test_requireEither_shouldParseRhsWhenLhsCannotBeParsed() throws {
        let children = try builder(",:")
                .requireEither({ try self.parser.parsePunctuation(.colon) }) {
                    try self.parser.parsePunctuation(.comma)
                }
                .build()
        XCTAssertEqual(children.count, 1)
        XCTAssertEqual(children[0].text, ",")
    }

    func test_requireEither_shouldThrowWhenNeitherRequiredParse() throws {
        XCTAssertThrowsError(try builder("<")
                .requireEither({ try self.parser.parsePunctuation(.colon) }) {
                    try self.parser.parsePunctuation(.comma)
                }
                .build())
    }

    // MARK: - check

    func test_shouldAbandonParsingWhenCheckFails() {
        XCTAssertThrowsError(try builder(",,")
                .optional { try self.parser.parsePunctuation(.comma) }
                .check { throw TestError() }
                .optional { try self.parser.parsePunctuation(.comma) }
                .build())
    }

    func test_shouldContinueParsingWhenCheckSucceeds() throws {
        let children = try builder(",,")
                .optional { try self.parser.parsePunctuation(.comma) }
                .check { /* succeed */ }
                .optional { try self.parser.parsePunctuation(.comma) }
                .build()
        XCTAssertEqual(children.count, 2)
        XCTAssertEqual(children[0].text, ",")
        XCTAssertEqual(children[1].text, ",")
    }

    private func builder(_ input: String) -> ParserBuilder {
        parser = createParser(input, FileParser.self)
        return parser.builder()
    }
}
