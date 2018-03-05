import XCTest
@testable import SwiftStructureInterface

class DeclarationsParserTests: XCTestCase {

    func test_parse_shouldParseProtocolWithMisspelledAccessModifier() {
        let parser = FileParser(fileContents: "publi protocol A {}")
        let file = parser.parse()
        let `protocol` = file.children[0] as? SwiftTypeElement
        XCTAssertEqual(`protocol`?.text, "protocol A {}")
        XCTAssertEqual(`protocol`?.name, "A")
        XCTAssertEqual(`protocol`?.offset, 6)
        XCTAssertEqual(`protocol`?.length, 13)
        XCTAssertEqual(`protocol`?.bodyOffset, 18)
        XCTAssertEqual(`protocol`?.bodyLength, 0)
    }
}
