import XCTest
@testable import SwiftStructureInterface

class BuildElementTextTests: XCTestCase {

    func test_shouldReturnEmptyStringWhenNoChildren() {
        XCTAssertEqual(TypeImpl.emptyType.text, "")
    }

    func test_shouldJoinTextFromAllLeafNodes() {
        let text = "func identifier"
        let parser = createParser(text, FileParser.self)
        let type = TypeImpl(children: [
            parser.parseKeyword(),
            parser.parseWhitespace(),
            try! parser.parseIdentifier()
        ])
        XCTAssertEqual(type.text, text)
    }

    func test_shouldJoinTextFromAllNestedLeafNodes() {
        let text = "Generic<T>"
        let parser = createParser(text, TypeParser.self)
        XCTAssertEqual(parser.parse().text, text)
    }
}
