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
        let contents = "Protocol P {}"
        let file = parse(contents)
        XCTAssertEqual(file.text, contents)
    }

    func test_parse_shouldParseUTF16File() {
        let contents = "protocol 💐 {}"
        let file = parse(contents)
        XCTAssertEqual(file.text, contents)
    }

    func test_parse_shouldParseComments() {
        let contents = "/* comment */protocol/* comment */P/* comment */{/* comment */}/* comment */"
        let file = parse(contents)
        XCTAssertEqual(file.text, contents)
    }

    private func parse(_ input: String) -> File {
        let parser = FileParser(fileContents: input)
        return try! parser.parse()
    }
}
