import XCTest
@testable import SwiftStructureInterface

protocol TypeParserTests {
}

extension TypeParserTests where Self: XCTestCase {

    func assertTypeText(_ input: String, _ expected: String, file: StaticString = #file, line: UInt = #line) {
        let element = parse(input)
        assertElementText(element, expected, file: file, line: line)
    }

    func assertErrorType(_ input: String, file: StaticString = #file, line: UInt = #line) {
        let element = parse(input)
        XCTAssertEqual(element.offset, 0, file: file, line: line)
    }

    func assertOffsetLength(_ input: String, _ expectedOffset: Int64, _ expectedLength: Int64, file: StaticString = #file, line: UInt = #line) {
        let element = parse(input)
        XCTAssertEqual(element.offset, expectedOffset, file: file, line: line)
        XCTAssertEqual(element.length, expectedLength, file: file, line: line)
    }

    func parse(_ text: String) -> TypeImpl {
        return createParser(text, TypeParser.self).parse() as! TypeImpl
    }

    func parseFunctionType(_ text: String) -> FunctionType {
        return parse(text) as! FunctionType
    }

    func parseTupleType(_ text: String) -> TupleType {
        return parse(text) as! TupleType
    }

    func parseOptionalType(_ text: String) -> OptionalType {
        return parse(text) as! OptionalType
    }
}
