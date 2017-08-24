import XCTest
@testable import SwiftStructureInterface

class CaretTestHelper {

    class func findCaretOffset(_ contents: String) -> (contents: String, offset: Int64?) {
        var contents = contents
        if let range = contents.range(of: "<caret>") {
            contents.removeSubrange(range)
            return (contents, Int64(contents.distance(from: contents.startIndex, to: range.lowerBound)))
        }
        return (contents, nil)
    }

    class func findCaretLineColumn(_ contents: String) -> (contents: String, lineColumn: (line: Int, column: Int)?) {
        let contentsOffset = findCaretOffset(contents)
        return (contentsOffset.contents, LocationConverter.convert(caretOffset: contentsOffset.offset ?? -1, in: contents))
    }
}

class CaretTestHelperTests: XCTestCase {

    // MARK: - findCaretOffset

    func test_findCaretOffset_shouldReturnNil_forEmptyString() {
        XCTAssertNil(CaretTestHelper.findCaretOffset("").offset)
        XCTAssertEqual(CaretTestHelper.findCaretOffset("").contents, "")
    }

    func test_findCaretOffset_shouldReturnPosition_forCaretOnlyContents() {
        let string = "<caret>"
        XCTAssertEqual(CaretTestHelper.findCaretOffset(string).offset, 0)
        XCTAssertEqual(CaretTestHelper.findCaretOffset(string).contents, "")
    }

    func test_findCaretOffset_shouldReturnPosition_forCaretAtBeginning() {
        let string = "<caret>class A {}"
        XCTAssertEqual(CaretTestHelper.findCaretOffset(string).offset, 0)
        XCTAssertEqual(CaretTestHelper.findCaretOffset(string).contents, "class A {}")
    }

    func test_findCaretOffset_shouldReturnPosition_forCaretAtEnd() {
        let string = "class A {}<caret>"
        XCTAssertEqual(CaretTestHelper.findCaretOffset(string).offset, 10)
        XCTAssertEqual(CaretTestHelper.findCaretOffset(string).contents, "class A {}")
    }

    func test_findCaretOffset_shouldReturnPosition_forCaretOnNewLine() {
        let string = "class A {" + "\n" +
            "  <caret>" + "\n" +
            "}"
        let expected = "class A {" + "\n" +
            "  " + "\n" +
            "}"
        XCTAssertEqual(CaretTestHelper.findCaretOffset(string).offset, 12)
        XCTAssertEqual(CaretTestHelper.findCaretOffset(string).contents, expected)
    }

    // MARK: - findCaretLineColumn

    func test_findCaretLineColumn_shouldReturnLineAndColumnConvertedFromOffset() {
        let string = "class A {" + "\n" +
            "  <caret>" + "\n" +
            "}"
        let expected = "class A {" + "\n" +
            "  " + "\n" +
            "}"
        XCTAssertEqual(CaretTestHelper.findCaretLineColumn(string).lineColumn?.line, 1)
        XCTAssertEqual(CaretTestHelper.findCaretLineColumn(string).lineColumn?.column, 2)
        XCTAssertEqual(CaretTestHelper.findCaretLineColumn(string).contents, expected)
    }
}
