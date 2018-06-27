import XCTest
@testable import SwiftStructureInterface

class BuildElementTextTests: XCTestCase {

    func test_shouldReturnEmptyStringWhenNoChildren() {
        XCTAssertEqual(TypeImpl.emptyType.text, "")
    }

    func test_shouldJoinTextFromAllLeafNodes() throws {
        let text = "func identifier"
        let parser = createParser(text, FileParser.self)
        let type = TypeImpl(children: [
            try parser.parseKeyword(),
            try parser.parseWhitespace(),
            try parser.parseIdentifier()
        ])
        XCTAssertEqual(type.text, text)
    }

    func test_shouldJoinTextFromAllNestedLeafNodes() {
        let text = "Generic<T>"
        let parser = createParser(text, TypeParser.self)
        XCTAssertEqual(try parser.parse().text, text)
    }
}
