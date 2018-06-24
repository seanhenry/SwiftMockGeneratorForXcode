import XCTest
@testable import SwiftStructureInterface

class FunctionTypeParserTests: XCTestCase, TypeParserTests {

    // MARK: - Function type

    func test_parse_shouldParseEmptyFunction() {
        let text = "() -> ()"
        let type = parseFunctionType(text)
        XCTAssert(type.attributes.attributes.isEmpty)
        XCTAssertEqual(type.arguments.text, "()")
        XCTAssertEqual(type.returnType.text, "()")
        XCTAssertFalse(type.throws)
        XCTAssertFalse(type.rethrows)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseFunctionWithReturnType() {
        let text = "() -> String"
        let type = parseFunctionType(text)
        XCTAssertEqual(type.returnType.text, "String")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseFunctionWithArgument() {
        let text = "(A) -> ()"
        let type = parseFunctionType(text)
        XCTAssertEqual(type.arguments.text, "(A)")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseFunctionWithWildcardArgument() {
        let text = "(_ a: A) -> ()"
        let type = parseFunctionType(text)
        XCTAssertEqual(type.arguments.text, "(_ a: A)")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseFunctionWithMissingReturnType() {
        XCTAssertNotNil(parse("() -> ") as? FunctionType)
    }

    func test_parse_shouldParseThrowingFunction() {
        let text = "() throws -> ()"
        let type = parseFunctionType(text)
        XCTAssert(type.throws)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseRethrowingFunction() {
        let text = "() rethrows -> ()"
        let type = parseFunctionType(text)
        XCTAssert(type.rethrows)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseAttributes() {
        let text = "@escaping @b () -> ()"
        let type = parseFunctionType(text)
        XCTAssertEqual(type.attributes.attributes[0].text, "@escaping")
        XCTAssertEqual(type.attributes.attributes[1].text, "@b")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseFunctionTypeMinimalWhitespace() {
        let text = "@escaping()throws->()"
        XCTAssertEqual(parseFunctionType(text).text, text)
    }

    func test_parse_shouldParseComplexFunction() {
        let text = "@escaping @autoclosure (_ gen: @a inout Generic.Nested<Inner>?, opt: Int?, T) rethrows -> [(String, returnType: Int):Int]"
        let type = parseFunctionType(text)
        XCTAssert(type is FunctionType)
        XCTAssertEqual(type.text, text)
    }
}
