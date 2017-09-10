import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SwiftPropertyElementBuilderTests: XCTestCase {

    // TODO: test all cases

    func test_build_shouldFindProperties() {
        let file = StructureBuilderTestHelper.build(from: getPropertiesExampleString())!
        assertChildProperty(file, name: "globalConstant", type: "", isWritable: false, at: 0)
        assertChildProperty(file, name: "globalVariable", type: "String", isWritable: true, at: 1)
        let protocolType = file.children[2] as! SwiftTypeElement
        assertChildProperty(protocolType, name: "readWrite", type: "String", isWritable: true, at: 0)
        assertChildProperty(protocolType, name: "readOnly", type: "Int", isWritable: false, at: 1)
        assertChildProperty(protocolType, name: "weakProp", type: "NSObject?", isWritable: false, attributes: "weak", at: 2)
    }

    // MARK: - Helpers

    func assertChildProperty(_ parent: Element?, name: String, type: String, isWritable: Bool, attributes: String? = nil, at index: Int, line: UInt = #line) {
        let property = parent?.children[index] as? SwiftPropertyElement
        XCTAssertEqual(property?.name, name, line: line)
        XCTAssertEqual(property?.type, type, line: line)
        XCTAssertEqual(property?.isWritable, isWritable, line: line)
        XCTAssertEqual(property?.attribute, attributes, line: line)
    }

    private func getPropertiesExampleString() -> String {
        return "let globalConstant = \"let\"" + "\n" +
            "var globalVariable: String = \"var\"" + "\n" +
            "protocol P {" + "\n" +
            "    var readWrite: String { set get }" + "\n" +
            "    var readOnly: Int { get }" + "\n" +
            "    weak var weakProp: NSObject? { get }" + "\n" +
            "}"
    }
}
