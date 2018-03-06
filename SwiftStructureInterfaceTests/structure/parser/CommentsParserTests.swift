import XCTest
@testable import SwiftStructureInterface

class CommentsParserTests: XCTestCase {

    var parser: Parser<SwiftTypeElement>!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseCommentBlocks() {
        let text = "/* comment */protocol/* comment */P/* comment */{/* comment */}/* comment */"
        let expected = "protocol/* comment */P/* comment */{/* comment */}"
        let commentLength = Int64("/* comment */".utf8.count)
        parser = createParser(text, ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.name, "P")
        XCTAssertEqual(`protocol`.text, expected)
        XCTAssertEqual(`protocol`.offset, commentLength)
        XCTAssertEqual(`protocol`.length, Int64(expected.utf8.count))
        XCTAssertEqual(`protocol`.bodyOffset, Int64(expected.utf8.count) - 1)
        XCTAssertEqual(`protocol`.bodyLength, commentLength)
    }

    func test_parse_shouldParseLineComments() {
        let text = "// comment\nprotocol// comment\nP// comment\n{// comment\n}// comment\n"
        let expected = "protocol// comment\nP// comment\n{// comment\n}"
        let commentLength = Int64("// comment\n".utf8.count)
        parser = createParser(text, ProtocolParser.self)
        let `protocol` = parser.parse()
        XCTAssertEqual(`protocol`.name, "P")
        XCTAssertEqual(`protocol`.text, expected)
        XCTAssertEqual(`protocol`.offset, commentLength)
        XCTAssertEqual(`protocol`.length, Int64(expected.utf8.count))
        XCTAssertEqual(`protocol`.bodyOffset, Int64(expected.utf8.count) - 1)
        XCTAssertEqual(`protocol`.bodyLength, commentLength)
    }
}
