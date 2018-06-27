import XCTest
@testable import SwiftStructureInterface

class TupleTypeParserTests: XCTestCase, TypeParserTests {

    // MARK: - Tuple

    func test_parse_shouldParseEmptyTuple() throws {
        let text = "()"
        let type = try parseTupleType(text)
        XCTAssert(type.tupleTypeElementList.tupleTypeElements.isEmpty)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseSingleBracketedType() throws {
        let text = "(Int)"
        let type = try parseTupleType(text)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements.count, 1)
        XCTAssertNil(type.tupleTypeElementList.tupleTypeElements[0].label)
        XCTAssertNil(type.tupleTypeElementList.tupleTypeElements[0].typeAnnotation)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[0].type?.text, "Int")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseMultipleArgumentsTuple() throws {
        let text = "(TypeA, [String:Int])"
        let type = try parseTupleType(text)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements.count, 2)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[0].text, "TypeA")
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[1].text, "[String:Int]")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseOptionalEmptyTuple() throws {
        let text = "()?"
        let type = try parseOptionalType(text)
        let tuple = type.type as! TupleType
        XCTAssertEqual(type.text, text)
        XCTAssertEqual(tuple.tupleTypeElementList.tupleTypeElements.count, 0)
        XCTAssertEqual(tuple.text, "()")
    }

    func test_parse_shouldParseOptionalTuple() throws {
        let text = "(TypeA, [Int])?"
        let type = try parseOptionalType(text)
        let tuple = type.type as! TupleType
        XCTAssertEqual(type.text, text)
        XCTAssertEqual(tuple.text, "(TypeA, [Int])")
        let elements = tuple.tupleTypeElementList.tupleTypeElements
        XCTAssertEqual(elements.count, 2)
        XCTAssertEqual(elements[0].text, "TypeA")
        XCTAssertEqual(elements[1].text, "[Int]")
    }

    func test_parse_shouldParseExplicitArgumentTuple() throws {
        let text = "(a: A, b, c: C.C<C>?)"
        let type = try parseTupleType(text)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[0].label, "a")
        XCTAssertNil(type.tupleTypeElementList.tupleTypeElements[1].label)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[2].label, "c")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldIgnoreWildcardArgumentsInTuple() throws {
        let text = "(_: A, _ b: B)"
        let type = try parseTupleType(text)
        XCTAssertNil(type.tupleTypeElementList.tupleTypeElements[0].label)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[1].label, "b")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseWhitespace() throws {
        let text = "( _ : A , _ b : B , C )"
        let type = try parseTupleType(text)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseTupleWithNoWhitespace() throws {
        let text = "(_:A,_ b:B,C)"
        let type = try parseTupleType(text)
        XCTAssertEqual(type.text, text)
    }
}
