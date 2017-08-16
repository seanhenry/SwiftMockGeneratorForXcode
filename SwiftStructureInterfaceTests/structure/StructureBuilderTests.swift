import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class StructureBuilderTests: XCTestCase {

    var builder: StructureBuilder!

    override func setUp() {
        super.setUp()
        builder = StructureBuilder()
    }

    override func tearDown() {
        builder = nil
        super.tearDown()
    }

    // MARK: - build

    func test_build_shouldBuildStructureFromDictionary() {
        let structure = builder.build(getProtocol())
        XCTAssertEqual(structure?.name, "Protocol")
        XCTAssertEqual(structure?.children.count, 2)
        XCTAssertEqual(structure?.children[0].name, "property")
        XCTAssertEqual(structure?.children[1].name, "method()")
    }

    // MARK: - Helpers

    func getProtocol() -> [String: SourceKitRepresentable] {
        let protocolDeclaration = "protocol Protocol {" + "\n" +
            "    " + "\n" +
            "    var property: String { get set }" + "\n" +
            "    " + "\n" +
            "    func method()" + "\n" +
            "}"
        return Structure(file: File(contents: protocolDeclaration))
            .dictionary
    }
}
