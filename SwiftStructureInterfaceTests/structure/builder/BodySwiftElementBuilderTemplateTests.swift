import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class BodySwiftElementBuilderTemplateTests: XCTestCase {

    func test_typeWithNoBodyOffsetIsIgnored() {
        assertNoBodyOffsetElementIsIgnored("protocol A {}")
        assertNoBodyOffsetElementIsIgnored("class A {}")
    }

    func test_typeWithNoBodyLengthIsIgnored() {
        assertNoBodyLengthElementIsIgnored("protocol A {}")
        assertNoBodyLengthElementIsIgnored("class A {}")
    }

    // MARK: - Helpers

    private func assertNoBodyOffsetElementIsIgnored(_ string: String, line: UInt = #line) {
        var fileData = try! Structure(file: File(contents: string)).dictionary
        var substructureData = fileData["key.substructure"] as! [[String: SourceKitRepresentable]]
        substructureData[0]["key.bodyoffset"] = nil
        fileData["key.substructure"] = substructureData
        let file = SKElementFactory().build(data: fileData, fileText: string)
        XCTAssertEqual(file?.children.count, 0, line: line)
    }

    private func assertNoBodyLengthElementIsIgnored(_ string: String, line: UInt = #line) {
        var fileData = try! Structure(file: File(contents: string)).dictionary
        var substructureData = fileData["key.substructure"] as! [[String: SourceKitRepresentable]]
        substructureData[0]["key.bodylength"] = nil
        fileData["key.substructure"] = substructureData
        let file = SKElementFactory().build(data: fileData, fileText: string)
        XCTAssertEqual(file?.children.count, 0, line: line)
    }
}
