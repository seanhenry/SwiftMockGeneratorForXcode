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
        parser = FileParser(fileContents: "protocol P {}")
        let file = parser.parse()
        XCTAssertEqual(file.text, "protocol P {}")
        XCTAssertEqual(file.offset, 0)
        XCTAssertEqual(file.length, 13)
    }

    func test_parse_shouldParseUTF16File() {
        parser = FileParser(fileContents: "protocol 💐 {}")
        let file = parser.parse()
        XCTAssertEqual(file.text, "protocol 💐 {}")
        XCTAssertEqual(file.offset, 0)
        XCTAssertEqual(file.length, 16)
    }

    func test_parse_shouldParseComments() {
        let contents = "/* comment */protocol/* comment */P/* comment */{/* comment */}/* comment */"
        parser = FileParser(fileContents: contents)
        let file = parser.parse()
        XCTAssertEqual(file.text, contents)
        XCTAssertEqual(file.offset, 0)
        XCTAssertEqual(file.length, Int64(contents.utf8.count))
    }
}
