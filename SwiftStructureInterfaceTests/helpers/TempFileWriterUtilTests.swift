import XCTest
@testable import SwiftStructureInterface

class TempFileWriterUtilTests: XCTestCase {

    var util: TempFileWriterUtil!

    override func setUp() {
        super.setUp()
        util = TempFileWriterUtil()
    }

    override func tearDown() {
        util = nil
        super.tearDown()
    }

    // MARK: - tempFile

    func test_tempFile_shouldWriteToADifferentFileEveryTime() {
        let writer = TempFileWriterUtil()
        writer.write("test")
        let file = writer.tempFile
        writer.write("test")
        XCTAssertNotEqual(writer.tempFile, file)
    }

    // MARK: - write

    func test_write_shouldWriteStringToFile() {
        util.write("test")
        XCTAssertEqual(try? String(contentsOfFile: util.tempFile), "test")
    }

    func test_write_shouldWriteArrayToFile() {
        util.write(["test\n", "lines"])
        XCTAssertEqual(try? String(contentsOfFile: util.tempFile), "test\nlines")
    }
}
