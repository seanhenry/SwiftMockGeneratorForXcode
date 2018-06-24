import XCTest
@testable import SwiftStructureInterface

class TupleTypeParserTests: XCTestCase, TypeParserTests {

    // MARK: - Tuple

    func test_parse_shouldParseEmptyTuple() {
        let text = "()"
        let type = parseTupleType(text)
        XCTAssert(type.tupleTypeElementList.tupleTypeElements.isEmpty)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseSingleBracketedType() {
        let text = "(Int)"
        let type = parseTupleType(text)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements.count, 1)
        XCTAssertNil(type.tupleTypeElementList.tupleTypeElements[0].label)
        XCTAssertNil(type.tupleTypeElementList.tupleTypeElements[0].typeAnnotation)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[0].type?.text, "Int")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseMultipleArgumentsTuple() {
        let text = "(TypeA, [String:Int])"
        let type = parseTupleType(text)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements.count, 2)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[0].text, "TypeA")
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[1].text, "[String:Int]")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseOptionalEmptyTuple() {
        let text = "()?"
        let type = parseOptionalType(text)
        let tuple = type.type as! TupleType
        XCTAssertEqual(type.text, text)
        XCTAssertEqual(tuple.tupleTypeElementList.tupleTypeElements.count, 0)
        XCTAssertEqual(tuple.text, "()")
    }

    func test_parse_shouldParseOptionalTuple() {
        let text = "(TypeA, [Int])?"
        let type = parseOptionalType(text)
        let tuple = type.type as! TupleType
        XCTAssertEqual(type.text, text)
        XCTAssertEqual(tuple.text, "(TypeA, [Int])")
        let elements = tuple.tupleTypeElementList.tupleTypeElements
        XCTAssertEqual(elements.count, 2)
        XCTAssertEqual(elements[0].text, "TypeA")
        XCTAssertEqual(elements[1].text, "[Int]")
    }

    func test_parse_shouldParseExplicitArgumentTuple() {
        let text = "(a: A, b, c: C.C<C>?)"
        let type = parseTupleType(text)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[0].label, "a")
        XCTAssertNil(type.tupleTypeElementList.tupleTypeElements[1].label)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[2].label, "c")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldIgnoreWildcardArgumentsInTuple() {
        let text = "(_: A, _ b: B)"
        let type = parseTupleType(text)
        XCTAssertNil(type.tupleTypeElementList.tupleTypeElements[0].label)
        XCTAssertEqual(type.tupleTypeElementList.tupleTypeElements[1].label, "b")
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseWhitespace() {
        let text = "( _ : A , _ b : B , C )"
        let type = parseTupleType(text)
        XCTAssertEqual(type.text, text)
    }

    func test_parse_shouldParseTupleWithNoWhitespace() {
        let text = "(_:A,_ b:B,C)"
        let type = parseTupleType(text)
        XCTAssertEqual(type.text, text)
    }
}
