import XCTest
@testable import SwiftStructureInterface

class GetterSetterKeywordBlockParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyBlock() throws {
        let text = "{}"
        let block = try parse(text)
        XCTAssertEqual(block.text, text)
        XCTAssertFalse(block.isWritable)
    }

    func test_parse_shouldParseGetOnlyBlock() throws {
        let text = "{get}"
        let block = try parse(text)
        XCTAssertEqual(block.text, text)
        XCTAssertFalse(block.isWritable)
    }

    func test_parse_shouldParseGetSet() throws {
        let text = "{get set}"
        let block = try parse(text)
        XCTAssertEqual(block.text, text)
    }

    func test_parse_shouldParseSetGet() throws {
        let text = "{set get}"
        let block = try parse(text)
        XCTAssertEqual(block.text, text)
        XCTAssert(block.isWritable)
    }

    func test_parse_shouldParseGetSetWhitespace() {
        let text = "{ set get }"
        XCTAssertEqual(try parse(text).text, text)
    }

    func test_parse_shouldParseGetWhitespace() {
        let text = "{ get }"
        XCTAssertEqual(try parse(text).text, text)
    }

    func test_parse_shouldParseSetGetWithAttributesAndMutationModifier() throws {
        let text = "{@a mutating set @b nonmutating get}"
        let block = try parse(text)
        XCTAssertEqual(block.text, text)
        XCTAssert(block.isWritable)
    }

    func test_shouldNotParseBlockWithoutOpeningBrace() {
        XCTAssertThrowsError(try parse("get set }"))
    }

    func test_shouldNotParseBlockWithoutClosingBrace() {
        XCTAssertThrowsError(try parse("{ get set").text)
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> GetterSetterKeywordBlock {
        return try createParser(text, GetterSetterKeywordBlockParser.self).parse()
    }
}
