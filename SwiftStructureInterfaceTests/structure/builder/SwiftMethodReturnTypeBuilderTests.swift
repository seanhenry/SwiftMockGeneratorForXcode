import XCTest
@testable import SwiftStructureInterface

class SwiftMethodReturnTypeBuilderTests: XCTestCase {

    var builder: SwiftMethodReturnTypeBuilder!
    var element: Element?

    override func tearDown() {
        builder = nil
        element = nil
        super.tearDown()
    }

    // MARK: - findReturnTypeRange

    func test_findReturnTypeRange_shouldReturnNil_whenNoReturnTypeInProtocolMethod() {
        setUpStandardBuilder("")
        XCTAssertNil(builder.build())
    }

    func test_findReturnTypeRange_shouldReturnNil_whenNoReturnTypeInClassMethod() {
        setUpStandardBuilder(" {}")
        XCTAssertNil(builder.build())
    }

    func test_findReturnTypeRange_shouldReturnElement_whenSimpleReturnType() {
        assertReturnTypeOffsets("->Int", 10, 3)
        assertReturnTypeString("Int")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenAnotherSimpleReturnType() {
        assertReturnTypeOffsets("->String", 10, 6)
        assertReturnTypeString("String")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenWhitespace() {
        assertReturnTypeOffsets(" -> Int ", 12, 3)
        assertReturnTypeString("Int")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenOptional() {
        assertReturnTypeOffsets(" -> Int? ", 12, 4)
        assertReturnTypeString("Int?")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenWeirdWhitespace() {
        assertReturnTypeOffsets(" \n\t-> \n\tInt \n\t", 16, 3)
        assertReturnTypeString("Int")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenClosure() {
        assertReturnTypeOffsets("->()->()", 10, 6)
        assertReturnTypeString("()->()")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenClosureWithWhitespace() {
        assertReturnTypeOffsets(" -> () -> () ", 12, 8)
        assertReturnTypeString("() -> ()")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenClosureWithArguments() {
        assertReturnTypeOffsets(" -> (Int, String) -> (Int, String)", 12, 30)
        assertReturnTypeString("(Int, String) -> (Int, String)")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenClosureWithNoBracketReturnType() {
        assertReturnTypeOffsets(" -> () -> String", 12, 12)
        assertReturnTypeString("() -> String")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenClosureSurroundedWithBrackets() {
        assertReturnTypeOffsets(" -> (() -> ())?", 12, 11)
        assertReturnTypeString("(() -> ())?")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenTuple() {
        assertReturnTypeOffsets(" -> (A, B)", 12, 6)
        assertReturnTypeString("(A, B)")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenThrows() {
        assertReturnTypeOffsets(" throws -> A", 19, 1)
        assertReturnTypeString("A")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenClosureArgument() {
        let string = "func a(a: () -> ()) -> Int"
        builder = SwiftMethodReturnTypeBuilder(methodDeclarationText: string, endOfParametersOffset: 18)
        element = builder.build()
        XCTAssertEqual(element?.offset, 23)
        XCTAssertEqual(element?.length, 3)
        assertReturnTypeString("Int")
    }

    func test_findReturnTypeRange_shouldIgnoreWhereClause() {
        let string = "func a<T>() -> T where T.Type == String"
        builder = SwiftMethodReturnTypeBuilder(methodDeclarationText: string, endOfParametersOffset: 10)
        element = builder.build()
        XCTAssertEqual(element?.offset, 15)
        XCTAssertEqual(element?.length, 1)
        assertReturnTypeString("T")
    }

    func test_findReturnTypeRange_shouldReturnRange_whenUTF16Characters() {
        // "💐".utf8.count = 4
        let string = "func 💐(a: Int) -> 💐Type"
        builder = SwiftMethodReturnTypeBuilder(methodDeclarationText: string, endOfParametersOffset: 16)
        element = builder.build()
        XCTAssertEqual(element?.offset, 21)
        XCTAssertEqual(element?.length, 8)
        assertReturnTypeString("💐Type")
    }

    // MARK: - Helpers

    func assertReturnTypeOffsets(_ returnString: String, _ expectedOffset: Int64, _ expectedLength: Int64, line: UInt = #line) {
        setUpStandardBuilder(returnString)
        element = builder.build()
        XCTAssertEqual(element?.offset, expectedOffset, line: line)
        XCTAssertEqual(element?.length, expectedLength, line: line)
    }

    func assertReturnTypeString(_ expectedString: String, line: UInt = #line) {
        XCTAssertEqual(element?.text, expectedString, line: line)
    }

    private func setUpStandardBuilder(_ string: String) {
        builder = SwiftMethodReturnTypeBuilder(methodDeclarationText: "func a()\(string)", endOfParametersOffset: 7)
    }
}
