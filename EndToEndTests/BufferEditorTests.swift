import XCTest
@testable import XcodePluginProxy

class BufferEditorTests: XCTestCase {

    func test_deleteShouldRemoveASingleLine() {
        let lines = delete(from: 0, length: 1)
        XCTAssertEqual(lines.count, 9)
        XCTAssertEqual(lines[0], "1")
    }

    func test_deleteShouldNotRemoveAnyLinesFromEmptyRange() {
        let lines = delete(from: 0, length: 0)
        XCTAssertEqual(lines.count, 10)
    }

    func test_deleteShouldNotRemoveAnyLinesFromInvalidRange() {
        XCTAssertEqual(delete(from: 1, length: -1).count, 10)
        XCTAssertEqual(delete(from: -2, length: 1).count, 10)
        XCTAssertEqual(delete(from: 0, length: 11).count, 10)
        XCTAssertEqual(delete(from: 0, length: 12).count, 10)
        XCTAssertEqual(delete(from: 10, length: 0).count, 10)
    }

    func test_deleteShouldRemoveRangeFromStartOfLines() {
        let lines = delete(from: 0, length: 5)
        XCTAssertEqual(lines.count, 5)
        XCTAssertEqual(lines[0], "5")
    }

    func test_deleteShouldRemoveRangeFromEndOfLines() {
        let lines = delete(from: 5, length: 5)
        XCTAssertEqual(lines.count, 5)
        XCTAssertEqual(lines[4], "4")
    }

    func test_deleteShouldRemoveRangeFromMiddleOfLines() {
        let lines = delete(from: 2, length: 5)
        XCTAssertEqual(lines.count, 5)
        XCTAssertEqual(lines[1], "1")
        XCTAssertEqual(lines[2], "7")
    }

    private func delete(from: Int, length: Int) -> [String] {
        let lines = [String](repeating: "", count: 10).enumerated().map { (i, _) in return "\(i)" } as NSArray
        let mutableLines = lines.mutableCopy() as! NSMutableArray
        BufferEditor().delete(from: from, length: length, in: mutableLines)
        return mutableLines as! [String]
    }

    func test_insertShouldInsertASingleLine() {
        let lines = insert(["10"], at: 0)
        XCTAssertEqual(lines.count, 11)
        XCTAssertEqual(lines[0], "10")
    }

    func test_insertShouldNotInsertAnyLinesFromEmptyInput() {
        let lines = insert([], at: 0)
        XCTAssertEqual(lines.count, 10)
    }

    func test_deleteShouldNotInsertAnyLinesFromInvalidIndex() {
        XCTAssertEqual(insert(["10"], at: -1).count, 10)
        XCTAssertEqual(insert(["10"], at: 11).count, 10)
        XCTAssertEqual(insert(["10"], at: 12).count, 10)
    }

    func test_insertShouldInsertAtStart() {
        let lines = insert(["10", "11", "12"], at: 0)
        XCTAssertEqual(lines.count, 13)
        XCTAssertEqual(lines[0], "10")
        XCTAssertEqual(lines[1], "11")
        XCTAssertEqual(lines[2], "12")
    }

    func test_insertShouldInsertAtEnd() {
        let lines = insert(["10", "11", "12"], at: 10)
        XCTAssertEqual(lines.count, 13)
        XCTAssertEqual(lines[10], "10")
        XCTAssertEqual(lines[11], "11")
        XCTAssertEqual(lines[12], "12")
    }

    func test_insertShouldInsertInMiddle() {
        let lines = insert(["10", "11", "12"], at: 3)
        XCTAssertEqual(lines.count, 13)
        XCTAssertEqual(lines[2], "2")
        XCTAssertEqual(lines[3], "10")
        XCTAssertEqual(lines[4], "11")
        XCTAssertEqual(lines[5], "12")
        XCTAssertEqual(lines[6], "3")
    }

    private func insert(_ toInsert: [String], at: Int) -> [String] {
        let lines = [String](repeating: "", count: 10).enumerated().map { (i, _) in return "\(i)" } as NSArray
        let mutableLines = lines.mutableCopy() as! NSMutableArray
        BufferEditor().insert(toInsert, into: mutableLines, at: at)
        return mutableLines as! [String]
    }
}
