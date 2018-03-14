import XCTest
@testable import SwiftStructureInterface

class GetterSetterKeywordBlockParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseEmptyBlock() {
        let text = "{ }"
        let block = parse(text)
        assertElementText(block, text)
        XCTAssertFalse(block.isWritable)
    }

    func test_parse_shouldParseGetOnlyBlock() {
        let text = "{ get }"
        let block = parse(text)
        assertElementText(block, text)
        XCTAssertFalse(block.isWritable)
    }

    func test_parse_shouldParseGetSet() {
        let text = "{ get set }"
        let block = parse(text)
        assertElementText(block, text)
        XCTAssert(block.isWritable)
    }

    func test_parse_shouldParseSetGet() {
        let text = "{ set get }"
        let block = parse(text)
        assertElementText(block, text)
        XCTAssert(block.isWritable)
    }

    func test_parse_shouldParseSetGetWithAttributesAndMutationModifier() {
        let text = "{ @a mutating set @b nonmutating get }"
        let block = parse(text)
        assertElementText(block, text)
        XCTAssert(block.isWritable)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> GetterSetterKeywordBlock {
        return createParser(text, GetterSetterKeywordBlockParser.self).parse()
    }
}
