import XCTest
@testable import SwiftStructureInterface

class FileParserTests: XCTestCase {

    var parser: FileParser!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseFile() {
        let contents = "protocol P {}"
        XCTAssertEqual(try parse(contents).text, contents)
    }

    func test_parse_shouldParseUTF16File() {
        let contents = "protocol 💐 {}"
        XCTAssertEqual(try parse(contents).text, contents)
    }

    func test_parse_shouldParseComments() {
        let contents = "/* comment */protocol/* comment */P/* comment */{/* comment */}/* comment */"
        XCTAssertEqual(try parse(contents).text, contents)
    }

    func test_parse_shouldParseWhitespaceAtBeginningAndEndOfFile() {
        let contents = "  protocol P {}  "
        XCTAssertEqual(try parse(contents).text, contents)
    }

    private func parse(_ input: String) throws -> File {
        let parser = FileParser(fileContents: input)
        return try parser.parse()
    }
}
