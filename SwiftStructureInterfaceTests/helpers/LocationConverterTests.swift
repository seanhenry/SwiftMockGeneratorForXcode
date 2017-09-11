import XCTest
@testable import SwiftStructureInterface

class LocationConverterTests: XCTestCase {

    // Note: lines start at 1, not 0

    // MARK: - convert(line:column:)

    func test_convert_shouldConvertZeroZeroToOffset() {
        XCTAssertEqual(LocationConverter.convert(line: 1, column: 0, in: "012345"), 0)
    }

    func test_convert_shouldConvertOneLineToOffset() {
        XCTAssertEqual(LocationConverter.convert(line: 1, column: 5, in: "012345"), 5)
    }

    func test_convert_shouldBeNil_whenColumnOutOfBounds() {
        XCTAssertNil(LocationConverter.convert(line: 1, column: 6, in: "012345"))
        XCTAssertNil(LocationConverter.convert(line: 1, column: -1, in: "012345"))
        XCTAssertNil(LocationConverter.convert(line: 2, column: 6, in: "012345\n012345"))
        XCTAssertNil(LocationConverter.convert(line: 2, column: -1, in: "012345\n012345"))
    }

    func test_convert_shouldBeNil_whenLineOutOfBounds() {
        XCTAssertNil(LocationConverter.convert(line: 0, column: 0, in: "012345"))
        XCTAssertNil(LocationConverter.convert(line: 2, column: 0, in: "012345"))
    }

    func test_convert_shouldCountNewlinesAndConvertToOffset() {
        XCTAssertEqual(LocationConverter.convert(line: 2, column: 0, in: "012345\n012345"), 7)
        XCTAssertEqual(LocationConverter.convert(line: 1, column: 6, in: "012345\n012345"), 6)
        XCTAssertEqual(LocationConverter.convert(line: 2, column: 5, in: "0123\n012345"), 10)
    }

    func test_convert_shouldCountLongerUnicodeScalarsAsManyOffsets() {
        // "©".utf8.count = 2
        // "💐".utf8.count = 4
        let string = "©💐\n©💐"
        XCTAssertEqual(LocationConverter.convert(line: 1, column: 0, in: string), 0)
        XCTAssertEqual(LocationConverter.convert(line: 1, column: 1, in: string), 2)
        XCTAssertEqual(LocationConverter.convert(line: 1, column: 2, in: string), 6)
        XCTAssertEqual(LocationConverter.convert(line: 2, column: 0, in: string), 7)
        XCTAssertEqual(LocationConverter.convert(line: 2, column: 1, in: string), 9)
        XCTAssertNil(LocationConverter.convert(line: 2, column: 2, in: string))
    }

    // MARK: - convert(caretOffset:)

    func test_convert_shouldConvertZeroToZeroZero() {
        assertOffset(0, convertsToLine: 1, column: 0, in: "012345")
    }

    func test_convert_shouldBeNil_whenCaretOutOfBounds() {
        XCTAssertNil(LocationConverter.convert(caretOffset: -1, in: "012345"))
        XCTAssertNil(LocationConverter.convert(caretOffset: 7, in: "012345"))
        XCTAssertNil(LocationConverter.convert(caretOffset: 14, in: "012345\n012345"))
    }

    func test_convert_shouldConvert_whenSingleLineString() {
        assertOffset(5, convertsToLine: 1, column: 5, in: "012345")
    }

    func test_convert_shouldConvert_whenMultiLineString() {
        assertOffset(6, convertsToLine: 1, column: 6, in: "012345\n012345")
        assertOffset(13, convertsToLine: 2, column: 6, in: "012345\n012345")
        assertOffset(7, convertsToLine: 2, column: 0, in: "012345\n012345")
        assertOffset(12, convertsToLine: 2, column: 5, in: "012345\n012345")
        assertOffset(0, convertsToLine: 1, column: 0, in: "012345\n012345")
        assertOffset(5, convertsToLine: 1, column: 5, in: "012345\n012345")
        assertOffset(8, convertsToLine: 2, column: 3, in: "0123\n012345")
    }

    func test_convert_shouldCountLongerUTF8CharsAsOneColumn() {
        // "©".utf8.count = 2
        // "💐".utf8.count = 4
        let string = "©💐\n©💐"
        assertOffset(0, convertsToLine: 1, column: 0, in: string)
        assertOffset(1, convertsToLine: 1, column: 0, in: string)
        assertOffset(2, convertsToLine: 1, column: 1, in: string)
        assertOffset(3, convertsToLine: 1, column: 1, in: string)
        assertOffset(4, convertsToLine: 1, column: 1, in: string)
        assertOffset(5, convertsToLine: 1, column: 1, in: string)
        assertOffset(6, convertsToLine: 1, column: 2, in: string)
        assertOffset(7, convertsToLine: 2, column: 0, in: string)
        assertOffset(8, convertsToLine: 2, column: 0, in: string)
        assertOffset(9, convertsToLine: 2, column: 1, in: string)
        assertOffset(10, convertsToLine: 2, column: 1, in: string)
        assertOffset(11, convertsToLine: 2, column: 1, in: string)
        assertOffset(12, convertsToLine: 2, column: 1, in: string)
        assertOffset(13, convertsToLine: 2, column: 2, in: string)
        XCTAssertNil(LocationConverter.convert(caretOffset: 14, in: string))
    }

    // MARK: - Helpers

    private func assertOffset(_ offset: Int64, convertsToLine line: Int, column: Int, in string: String, fileLine: UInt = #line) {
        let lineColumn = LocationConverter.convert(caretOffset: offset, in: string)
        XCTAssertEqual(lineColumn?.line, line, "Line expected: \(line) got: \(String(describing: lineColumn?.line))", line: fileLine)
        XCTAssertEqual(lineColumn?.column, column, "Column expected: \(column) got: \(String(describing: lineColumn?.column))", line: fileLine)

    }
}
