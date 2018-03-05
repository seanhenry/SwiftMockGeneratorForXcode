import XCTest
@testable import SwiftStructureInterface

class ParserTests: XCTestCase {

    var parser: Parser!

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - parse

    func test_parse_shouldParseFile() {
        parser = Parser(fileContents: "protocol P {}")
        let file = parser.parse()
        XCTAssertEqual(file?.text, "protocol P {}")
        XCTAssertEqual(file?.offset, 0)
        XCTAssertEqual(file?.length, 13)
    }

    func test_parse_shouldParseUTF16File() {
        parser = Parser(fileContents: "protocol 💐 {}")
        let file = parser.parse()
        XCTAssertEqual(file?.text, "protocol 💐 {}")
        XCTAssertEqual(file?.offset, 0)
        XCTAssertEqual(file?.length, 16)
    }

    func test_parse_shouldParseProtocol() {
        parser = Parser(fileContents: "protocol P {}")
        let file = parser.parse()
        let `protocol` = file?.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol P {}")
        XCTAssertEqual(`protocol`?.name, "P")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 13)
        XCTAssertEqual(`protocol`?.bodyOffset, 12)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParsePartialProtocolWithoutClosingBrace() {
        parser = Parser(fileContents: "protocol A {")
        let file = parser.parse()
        let `protocol` = file?.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol A {")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 12)
        XCTAssertEqual(`protocol`?.bodyOffset, 12)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

    func test_parse_shouldParsePartialProtocolWithoutOpeningBrace() {
        parser = Parser(fileContents: "protocol A")
        let file = parser.parse()
        let `protocol` = file?.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol A")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 0)
        XCTAssertEqual(`protocol`?.length, 10)
        XCTAssertEqual(`protocol`?.bodyOffset, 10)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }

}
