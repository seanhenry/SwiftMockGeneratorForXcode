import XCTest
@testable import SwiftStructureInterface

class LocationConverterTests: XCTestCase {

    // MARK: - convert(line:column:)

    func test_convert_shouldConvertZeroZeroToOffset() {
        XCTAssertEqual(LocationConverter.convert(line: 0, column: 0, in: "012345"), 0)
    }

    func test_convert_shouldConvertOneLineToOffset() {
        XCTAssertEqual(LocationConverter.convert(line: 0, column: 5, in: "012345"), 5)
    }

    func test_convert_shouldBeNil_whenColumnOutOfBounds() {
        XCTAssertNil(LocationConverter.convert(line: 0, column: 6, in: "012345"))
        XCTAssertNil(LocationConverter.convert(line: 0, column: -1, in: "012345"))
        XCTAssertNil(LocationConverter.convert(line: 1, column: 6, in: "012345\n012345"))
        XCTAssertNil(LocationConverter.convert(line: 1, column: -1, in: "012345\n012345"))
    }

    func test_convert_shouldBeNil_whenLineOutOfBounds() {
        XCTAssertNil(LocationConverter.convert(line: -1, column: 0, in: "012345"))
        XCTAssertNil(LocationConverter.convert(line: 1, column: 0, in: "012345"))
    }

    func test_convert_shouldCountNewlinesAndConvertToOffset() {
        XCTAssertEqual(LocationConverter.convert(line: 1, column: 0, in: "012345\n012345"), 7)
        XCTAssertEqual(LocationConverter.convert(line: 1, column: 5, in: "0123\n012345"), 10)
    }

    func test_convert_shouldCountSpecialCharsAsOne() {
        XCTAssertEqual(LocationConverter.convert(line: 1, column: 3, in: "0123🎉\n0123"), 9)
    }

    // MARK: - convert(caretOffset:)

    func test_convert_shouldConvertZeroToZeroZero() {
        assertOffset(0, convertsToLine: 0, column: 0, in: "012345")
    }

    func test_convert_shouldBeNil_whenCaretOutOfBounds() {
        XCTAssertNil(LocationConverter.convert(caretOffset: -1, in: "012345"))
        XCTAssertNil(LocationConverter.convert(caretOffset: 7, in: "012345"))
        XCTAssertNil(LocationConverter.convert(caretOffset: 14, in: "012345\n012345"))
    }

    func test_convert_shouldConvert_whenSingleLineString() {
        assertOffset(5, convertsToLine: 0, column: 5, in: "012345")
    }

    func test_convert_shouldConvert_whenMultiLineString() {
        assertOffset(6, convertsToLine: 0, column: 6, in: "012345\n012345")
        assertOffset(13, convertsToLine: 1, column: 6, in: "012345\n012345")
        assertOffset(7, convertsToLine: 1, column: 0, in: "012345\n012345")
        assertOffset(12, convertsToLine: 1, column: 5, in: "012345\n012345")
        assertOffset(0, convertsToLine: 0, column: 0, in: "012345\n012345")
        assertOffset(5, convertsToLine: 0, column: 5, in: "012345\n012345")
        assertOffset(8, convertsToLine: 1, column: 3, in: "0123\n012345")
    }

    func test_convert_shouldCountSpecialCharsAsOneColumn() {
        assertOffset(6, convertsToLine: 1, column: 1, in: "0123\n🎉123")
    }

    // MARK: - Helpers

    private func assertOffset(_ offset: Int64, convertsToLine line: Int, column: Int, in string: String, fileLine: UInt = #line) {
        let lineColumn = LocationConverter.convert(caretOffset: offset, in: string)
        XCTAssertEqual(lineColumn?.line, line, "Line expected: \(line) got: \(String(describing: lineColumn?.line))", line: fileLine)
        XCTAssertEqual(lineColumn?.column, column, "Column expected: \(column) got: \(String(describing: lineColumn?.column))", line: fileLine)

    }
}
