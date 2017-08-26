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

    func test_tempFile_shouldBeDifferentEveryTime() {
        XCTAssertNotEqual(TempFileWriterUtil().tempFile, TempFileWriterUtil().tempFile)
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
