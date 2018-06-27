import XCTest
@testable import SwiftStructureInterface

class FunctionTypeParserTests: XCTestCase, TypeParserTests {

    // MARK: - Function type

    func test_parse_shouldParseEmptyFunction() throws {
        let text = "() -> ()"
        let type = try parseFunctionType(text)
        XCTAssert(type.attributes.attributes.isEmpty)
        XCTAssertEqual(type.arguments.text, "()")
        XCTAssertEqual(type.returnType.text, "()")
        XCTAssertFalse(type.throws)
        XCTAssertFalse(type.rethrows)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseFunctionWithReturnType() throws {
        let text = "() -> String"
        let type = try parseFunctionType(text)
        XCTAssertEqual(type.returnType.text, "String")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseFunctionWithArgument() throws {
        let text = "(A) -> ()"
        let type = try parseFunctionType(text)
        XCTAssertEqual(type.arguments.text, "(A)")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseFunctionWithWildcardArgument() throws {
        let text = "(_ a: A) -> ()"
        let type = try parseFunctionType(text)
        XCTAssertEqual(type.arguments.text, "(_ a: A)")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseFunctionWithMissingReturnType() throws {
        XCTAssertNotNil(try parseFunctionType("() -> "))
    }

    func test_parse_shouldParseThrowingFunction() throws {
        let text = "() throws -> ()"
        let type = try parseFunctionType(text)
        XCTAssert(type.throws)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseRethrowingFunction() throws {
        let text = "() rethrows -> ()"
        let type = try parseFunctionType(text)
        XCTAssert(type.rethrows)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseAttributes() throws {
        let text = "@escaping @b () -> ()"
        let type = try parseFunctionType(text)
        XCTAssertEqual(type.attributes.attributes[0].text, "@escaping")
        XCTAssertEqual(type.attributes.attributes[1].text, "@b")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseFunctionTypeMinimalWhitespace() throws {
        let text = "@escaping()throws->()"
        XCTAssertEqual(try parseFunctionType(text).text, text)
    }

    func test_parse_shouldParseComplexFunction() throws {
        let text = "@escaping @autoclosure (_ gen: @a inout Generic.Nested<Inner>?, opt: Int?, T) rethrows -> [(String, returnType: Int):Int]"
        let type = try parseFunctionType(text)
        XCTAssertEqual(type.text, text)
    }
}
