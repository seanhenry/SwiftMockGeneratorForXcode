import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class NamedSwiftElementBuilderTemplateTests: XCTestCase {

    func test_build_shouldNotCreateProtocol_whenNoName() {
        assertNoNameElementIsIgnored("protocol P {}")
        assertNoNameElementIsIgnored("class P {}")
    }

    func test_build_shouldNotCreateMethod_whenNoName() {
        assertNoNameElementIsIgnored("func m() {}")
    }

    func test_build_shouldNotCreateProperty_whenNoName() {
        assertNoNameElementIsIgnored("var p = 0")
    }

    // MARK: - Helpers

    private func assertNoNameElementIsIgnored(_ string: String, line: UInt = #line) {
        var fileData = Structure(file: File(contents: string)).dictionary
        var substructureData = fileData["key.substructure"] as! [[String: SourceKitRepresentable]]
        substructureData[0]["key.name"] = nil
        fileData["key.substructure"] = substructureData
        let file = SKElementFactory().build(data: fileData, fileText: string)
        XCTAssertEqual(file?.children.count, 0, line: line)
    }
}
