import XCTest
@testable import SwiftStructureInterface

class TypeCastingOperatorParserTests: XCTestCase {

    func test_shouldParseAsCast() throws {
        let text = "as T"
        let op = try parse(text)
        XCTAssertEqual(op.text, text)
    }

    func test_shouldParseOptionalAsCast() throws {
        let text = "as? T"
        let op = try parse(text)
        XCTAssertEqual(op.text, text)
    }

    func test_shouldParseForcedAsCast() throws {
        let text = "as! T"
        let op = try parse(text)
        XCTAssertEqual(op.text, text)
    }

    func test_shouldParseIsCast() throws {
        let text = "is T"
        let op = try parse(text)
        XCTAssertEqual(op.text, text)
    }

    private func parse(_ input: String) throws -> TypeCastingOperator {
        return try createParser(input, TypeCastingOperatorParser.self).parse()
    }
}
