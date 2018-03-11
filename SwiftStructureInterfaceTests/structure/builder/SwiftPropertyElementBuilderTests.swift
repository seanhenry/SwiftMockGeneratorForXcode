import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

protocol P {
    unowned(safe) var a : NSObject { get }
    unowned(unsafe) var b : NSObject { get }
}
class SwiftPropertyElementBuilderTests: XCTestCase {

    // This is a trivial implementation so far. Enough to detect protocol properties.

    func test_build_shouldFindProperties() {
        let file = SKElementFactoryTestHelper.build(from: getPropertiesExampleString())!
        assertChildProperty(file, name: "globalConstant", type: "", isWritable: false, at: 0)
        assertChildProperty(file, name: "globalVariable", type: "String", isWritable: true, at: 1)
        let protocolType = file.children[2] as! SwiftTypeElement
        assertChildProperty(protocolType, name: "readWrite", type: "String", isWritable: true, at: 0)
        assertChildProperty(protocolType, name: "readOnly", type: "Int", isWritable: false, at: 1)
        assertChildProperty(protocolType, name: "weakProp", type: "NSObject?", isWritable: false, at: 2)
        assertChildProperty(protocolType, name: "unownedProp", type: "NSObject", isWritable: false, at: 3)
        assertChildProperty(protocolType, name: "unownedWithWhitespace", type: "NSObject", isWritable: false, at: 4)
        assertChildProperty(protocolType, name: "weakWithNewline", type: "NSObject?", isWritable: false, at: 5)
        assertChildProperty(protocolType, name: "unownedSafe", type: "NSObject", isWritable: false, at: 6)
        assertChildProperty(protocolType, name: "unownedUnsafe", type: "NSObject", isWritable: false, at: 7)
    }

    // MARK: - Helpers

    func assertChildProperty(_ parent: Element?, name: String, type: String, isWritable: Bool, at index: Int, line: UInt = #line) {
        let property = parent?.children[index] as? VariableDeclaration
        XCTAssertEqual(property?.name, name, line: line)
        XCTAssertEqual(property?.type.text, type, line: line)
        XCTAssertEqual(property?.isWritable, isWritable, line: line)
    }

    private func getPropertiesExampleString() -> String {
        return """
            let globalConstant = \"let\"
            var globalVariable: String = \"var\"
            protocol P {
                var readWrite: String { set get }
                var readOnly: Int { get }
                weak var weakProp: NSObject? { get }
                unowned var unownedProp: NSObject { get }
                unowned     var unownedWithWhitespace: NSObject { get }
                weak \n var weakWithNewline: NSObject? { get }
                unowned(safe) \n var unownedSafe: NSObject { get }
                unowned(unsafe) \n var unownedUnsafe: NSObject { get }
            }
            """
    }
}
