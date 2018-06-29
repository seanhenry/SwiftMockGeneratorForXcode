import XCTest
@testable import SwiftStructureInterface

class FunctionCallArgumentListParserTests: XCTestCase {

    func test_shouldParseSingleItemList() throws {
        let text = "expression"
        let list = try parse(text)
        XCTAssertEqual(list.text, text)
    }

    func test_shouldParseSingleItemListWithLabel() throws {
        let text = "identifier: expression"
        let list = try parse(text)
        XCTAssertEqual(list.text, text)
    }

    func test_shouldParseWildcardIdentifier() throws {
        let text = "_: expression, _"
        let list = try parse(text)
        XCTAssertEqual(list.text, text)
    }

    func test_shouldParseManyItemsList() throws {
        let text = "expression, identifier: expression"
        let list = try parse(text)
        XCTAssertEqual(list.text, text)
    }

    func test_shouldParseOperatorsInList() throws {
        let text = "++, identifier: ~=, -,~, <==>"
        let list = try parse(text)
        XCTAssertEqual(list.text, text)
    }

    func test_shouldNotParseItemsWhenNoExpression() {
        XCTAssertThrowsError(try parse(""))
    }

    private func parse(_ input: String) throws -> FunctionCallArgumentList {
        return try createParser(input, FunctionCallArgumentListParser.self).parse()
    }
}
