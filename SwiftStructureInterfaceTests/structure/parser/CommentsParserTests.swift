import XCTest
@testable import SwiftStructureInterface

class CommentsParserTests: XCTestCase {

    // MARK: - parse

    func test_parse_shouldParseCommentBlocks() {
        let text = "/* comment */protocol/* comment */P/* comment */{/* comment */}/* comment */"
        let expected = "protocol/* comment */P/* comment */{/* comment */}"
        let commentLength = Int64("/* comment */".utf8.count)
        let `protocol` = parse(text)
        XCTAssertEqual(`protocol`.name, "P")
        XCTAssertEqual(`protocol`.text, expected)
    }

    func test_parse_shouldParseLineComments() {
        let text = "// comment\nprotocol// comment\nP// comment\n{// comment\n}// comment\n"
        let expected = "protocol// comment\nP// comment\n{// comment\n}"
        let commentLength = Int64("// comment\n".utf8.count)
        let `protocol` = parse(text)
        XCTAssertEqual(`protocol`.name, "P")
        XCTAssertEqual(`protocol`.text, expected)
    }

    // MARK: - Helpers

    func parse(_ text: String) -> TypeDeclaration {
        let parser = createDeclarationParser(text, .protocol, ProtocolDeclarationParser.self)
        return parser.parse()
    }
}
