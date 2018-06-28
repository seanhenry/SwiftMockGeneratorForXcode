@testable import SwiftStructureInterface
import XCTest

class ElementFindChildrenTests: XCTestCase {

    func testShouldFindFirstElementOfType() throws {
        let parameter = try parseParameter("a b : C")
        XCTAssertEqual(parameter.first(Identifier.self)?.text, "a")
    }

    func testShouldReturnNilWhenNoElementOfType() throws {
        let parameter = try parseParameter("_ a : A")
        XCTAssertNil(parameter.first(GenericParameterClause.self))
    }

    func testShouldFindSecondElementOfType() throws {
        let parameter = try parseParameter("a b : C")
        XCTAssertEqual(parameter.second(Identifier.self)?.text, "b")
    }

    func testShouldReturnNilWhenNoSecondElementOfType() throws {
        let parameter = try parseParameter("a : A")
        XCTAssertNil(parameter.second(Identifier.self))
    }

    func testShouldFindLastElementOfType() throws {
        let parameter = try parseParameter("a b : C")
        XCTAssertEqual(parameter.last(Identifier.self)?.text, "b")
    }

    func testShouldReturnLastElementOfTypeWhenOnlyOneType() throws {
        let parameter = try parseParameter("a : A")
        XCTAssertEqual(parameter.last(Identifier.self)?.text, "a")
    }

    func testShouldReturnFalseWhenNoLeafElementContainsText() throws {
        let parameter = try parseParameter("a : A")
        XCTAssertFalse(parameter.contains("b"))
    }

    func testShouldReturnTrueWhenLeafElementContainsText() throws {
        let parameter = try parseParameter("a b : A")
        XCTAssert(parameter.contains("b"))
    }

    func test_contains_shouldOnlySearchForLeafElements() throws {
        let parameter = try parseParameter("a b : A")
        XCTAssertFalse(parameter.contains(": A"))
    }

    func testShouldReturnTrueWhenFirstItemContainsLeafElement() throws {
        let parameter = try parseParameter("a b : A")
        XCTAssert(parameter.contains(["b", "z"]))
    }

    func testShouldReturnTrueWhenLastItemContainsLeafElement() throws {
        let parameter = try parseParameter("a b : A")
        XCTAssert(parameter.contains(["z", "a"]))
    }

    func testShouldReturnFalseWhenNoItemsContainsLeafElement() throws {
        let parameter = try parseParameter("a b : A")
        XCTAssertFalse(parameter.contains(["y", "z"]))
    }

    func testShouldReturnFalseWhenEmptyArray() throws {
        let parameter = try parseParameter("a b : A")
        XCTAssertFalse(parameter.contains([]))
    }

    private func parseParameter(_ input: String) throws -> Parameter {
        return try createParser(input, ParameterParser.self).parse()
    }
}
