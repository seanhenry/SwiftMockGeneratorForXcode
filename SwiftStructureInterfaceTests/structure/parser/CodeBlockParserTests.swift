import XCTest
@testable import SwiftStructureInterface

class CodeBlockParserTests: XCTestCase {

    func test_shouldParseBlock() throws {
        let text = "{}"
        let block = try parse(text)
        XCTAssertEqual(block.text, text)
    }

    func test_shouldParseBlockWithUnsupportedStatements() throws {
        let text = """
        {
        func a() {}
        var b: B { get { return "" } set { val = newValue } }
        }
        """
        let block = try parse(text)
        XCTAssertEqual(block.text, text)
    }

    private func parse(_ input: String) throws -> CodeBlock {
        return try createParser(input, CodeBlockParser.self).parse()
    }
}
