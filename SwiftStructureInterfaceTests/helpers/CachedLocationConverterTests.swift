import XCTest
@testable import SwiftStructureInterface

class CachedLocationConverterTests: XCTestCase {

    // Note: lines start at 1, not 0

    // MARK: - convertToOffset(line:column:)

    func test_convert_shouldConvertZeroZeroToOffset() {
        assertOffset("012345", 0, atLine: 1, column: 0)
    }

    func test_convert_shouldConvertOneLineToOffset() {
        assertOffset("012345", 6, atLine: 1, column: 6)
    }

    func test_convert_shouldBeNil_whenColumnOutOfBounds() {
        assertNilOffset("012345", atLine: 1, column: 7)
        assertNilOffset("012345", atLine: 1, column: -1)
        assertNilOffset("012345\n012345", atLine: 2, column: 7)
        assertNilOffset("012345\n012345", atLine: 2, column: -1)
    }

    func test_convert_shouldBeNil_whenLineOutOfBounds() {
        assertNilOffset("012345", atLine: 0, column: 0)
        assertNilOffset("012345", atLine: 2, column: 0)
    }

    func test_convert_shouldCountNewlinesAndConvertToOffset() {
        assertOffset("012345\n012345", 7, atLine: 2, column: 0)
        assertOffset("012345\n012345", 6, atLine: 1, column: 6)
        assertOffset("0123\n012345", 11, atLine: 2, column: 6)
    }

    func test_convert_shouldCountLongerUnicodeScalarsAsManyOffsets() {
        // "©".utf8.count = 2
        // "💐".utf8.count = 4
        let string = "©💐\n©💐"
        assertOffset(string, 0, atLine: 1, column: 0)
        assertOffset(string, 2, atLine: 1, column: 1)
        assertOffset(string, 6, atLine: 1, column: 2)
        assertOffset(string, 7, atLine: 2, column: 0)
        assertOffset(string, 13, atLine: 2, column: 2)
        assertNilOffset(string, atLine: 2, column: 3)
    }

    // MARK: - convertToIndex(line:column:)

    func test_convert_shouldConvertZeroToIndex() {
        assertIndex("012345", 0, atLine: 1, column: 0)
    }

    func test_convert_shouldConvertOneLineToIndex() {
        assertIndex("012345", 6, atLine: 1, column: 6)
    }

    func test_convert_shouldBeNilIndex_whenColumnOutOfBounds() {
        assertNilIndex("012345", atLine: 1, column: 7)
        assertNilIndex("012345", atLine: 1, column: -1)
        assertNilIndex("012345\n012345", atLine: 2, column: 7)
        assertNilIndex("012345\n012345", atLine: 2, column: -1)
    }

    func test_convert_shouldBeNilIndex_whenLineOutOfBounds() {
        assertNilIndex("012345", atLine: 0, column: 0)
        assertNilIndex("012345", atLine: 2, column: 0)
    }

    func test_convert_shouldCountNewlinesAndConvertToIndex() {
        assertIndex("012345\n012345", 7, atLine: 2, column: 0)
        assertIndex("012345\n012345", 6, atLine: 1, column: 6)
        assertIndex("0123\n012345", 11, atLine: 2, column: 6)
    }

    func test_convert_shouldCountLongerUnicodeScalarsAsManyIndexes() {
        // "©".utf8.count = 2
        // "💐".utf8.count = 4
        let string = "©💐\n©💐"
        assertIndex(string, 0, atLine: 1, column: 0)
        assertIndex(string, 2, atLine: 1, column: 1)
        assertIndex(string, 6, atLine: 1, column: 2)
        assertIndex(string, 7, atLine: 2, column: 0)
        assertIndex(string, 13, atLine: 2, column: 2)
        assertNilIndex(string, atLine: 2, column: 3)
    }
    
    // MARK: - Helpers

    func assertOffset(_ text: String, _ expectedOffset: Int64, atLine l: Int, column: Int, line: UInt = #line) {
        let offset = CachedLocationConverter(text).convertToOffset(line: l, column: column)
        XCTAssertEqual(offset, expectedOffset, line: line)
    }

    func assertNilOffset(_ text: String, atLine l: Int, column: Int, line: UInt = #line) {
        let offset = CachedLocationConverter(text).convertToOffset(line: l, column: column)
        XCTAssertNil(offset, line: line)
    }

    func assertIndex(_ text: String, _ indexOffset: Int, atLine l: Int, column: Int, line: UInt = #line) {
        let expectedIndex = text.utf8.index(text.utf8.startIndex, offsetBy: indexOffset)
        let index = CachedLocationConverter(text).convertToIndex(line: l, column: column)
        XCTAssertEqual(index, expectedIndex, line: line)
    }

    func assertNilIndex(_ text: String, atLine l: Int, column: Int, line: UInt = #line) {
        let index = CachedLocationConverter(text).convertToIndex(line: l, column: column)
        XCTAssertNil(index, line: line)
    }
}
