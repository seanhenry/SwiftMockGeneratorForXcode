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
}
