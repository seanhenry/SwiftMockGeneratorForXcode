import XCTest
@testable import SwiftStructureInterface

class CommentsParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseCommentBlocks() throws {
        let text = "/* comment1 */protocol/* comment2 */P/* comment3 */{/* comment4 */}/* comment5 */"
        let expected = "protocol/* comment2 */P/* comment3 */{/* comment4 */}"
        let `protocol` = try parse(text)
        XCTAssertEqual(`protocol`.name, "P")
        XCTAssertEqual(`protocol`.text, expected)
    }

    func test_parse_shouldParseLineComments() throws {
        let text = "// comment\nprotocol// comment\nP// comment\n{// comment\n}// comment\n"
        let expected = "protocol// comment\nP// comment\n{// comment\n}"
        let `protocol` = try parse(text)
        XCTAssertEqual(`protocol`.name, "P")
        XCTAssertEqual(`protocol`.text, expected)
    }

    // MARK: - Helpers

    func parse(_ text: String) throws -> TypeDeclaration {
        let parser = createDeclarationParser(text, .protocol, ProtocolDeclarationParser.self)
        return try parser.parse()
    }
}
