import XCTest
@testable import SwiftStructureInterface

class GetterSetterKeywordBlockParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyBlock() {
        let text = "{ }"
        let block = parse(text)
        XCTAssertEqual(block.text, text)
        XCTAssertEqual(block.offset, 0)
        XCTAssertEqual(block.length, Int64(text.utf8.count))
        XCTAssertFalse(block.isWritable)
    }

    func test_parse_shouldParseGetOnlyBlock() {
        let text = "{ get }"
        let block = parse(text)
        XCTAssertEqual(block.text, text)
        XCTAssertEqual(block.offset, 0)
        XCTAssertEqual(block.length, Int64(text.utf8.count))
        XCTAssertFalse(block.isWritable)
    }

    func test_parse_shouldParseGetSet() {
        let text = "{ get set }"
        let block = parse(text)
        XCTAssertEqual(block.text, text)
        XCTAssertEqual(block.offset, 0)
        XCTAssertEqual(block.length, Int64(text.utf8.count))
        XCTAssert(block.isWritable)
    }

    func test_parse_shouldParseSetGet() {
        let text = "{ set get }"
        let block = parse(text)
        XCTAssertEqual(block.text, text)
        XCTAssertEqual(block.offset, 0)
        XCTAssertEqual(block.length, Int64(text.utf8.count))
        XCTAssert(block.isWritable)
    }

    func test_parse_shouldParseSetGetWithAttributesAndMutationModifier() {
        let text = "{ @a mutating set @b nonmutating get }"
        let block = parse(text)
        XCTAssertEqual(block.text, text)
        XCTAssertEqual(block.offset, 0)
        XCTAssertEqual(block.length, Int64(text.utf8.count))
        XCTAssert(block.isWritable)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> GetterSetterKeywordBlock {
        let parser = createParser(text, GetterSetterKeywordBlockParser.self)
        return parser.parse()
    }
}
