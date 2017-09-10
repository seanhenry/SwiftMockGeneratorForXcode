import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SwiftElementBuilderTemplateTests: XCTestCase {

    func test_build_shouldNotCreateFile_whenTextIsSmallerThanData() {
        let protocolData = Structure(file: File(contents: "protocol P {}")).dictionary
        let file = SKElementFactory().build(data: protocolData, fileText: "protocol P {")
        XCTAssertNil(file)
    }

    func test_build_shouldNotCreateFile_whenNoOffset() {
        var fileData = Structure(file: File(contents: "protocol P {}")).dictionary
        fileData["key.offset"] = nil
        let file = SKElementFactory().build(data: fileData, fileText: "protocol P {}")
        XCTAssertNil(file)
    }

    func test_build_shouldNotCreateFile_whenNoLength() {
        var fileData = Structure(file: File(contents: "protocol P {}")).dictionary
        fileData["key.length"] = nil
        let file = SKElementFactory().build(data: fileData, fileText: "protocol P {}")
        XCTAssertNil(file)
    }

    func test_build_shouldNotCreateFile_whenOffsetIsOutOfBounds() {
        var fileData = Structure(file: File(contents: "protocol P {}")).dictionary
        fileData["key.offset"] = Int64(14)
        let file = SKElementFactory().build(data: fileData, fileText: "protocol P {}")
        XCTAssertNil(file)
    }
}
