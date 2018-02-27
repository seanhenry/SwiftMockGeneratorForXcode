import XCTest
@testable import SwiftStructureInterface

class SwiftTypealiasBuilderTests: XCTestCase {

    var builder: SwiftTypealiasBuilder!

    override func setUp() {
        super.setUp()

        builder = SwiftTypealiasBuilder(data: [:], fileText: "")
    }

    override func tearDown() {
        builder = nil
        super.tearDown()
    }

    // MARK: - build

    func test_build_shouldBuildTypealias() {
        let alias = SKElementFactory().build(data: getTypealiasData(), fileText: getTypealiasString()) as! Typealias
        XCTAssertEqual(alias.typeName, "Type")
    }

    func test_build_shouldBuildOtherElementProperties() {
        let alias = SKElementFactory().build(data: getTypealiasData(), fileText: getTypealiasString()) as! Typealias
        XCTAssertEqual(alias.text, "typealias Name = Type")
        XCTAssertEqual(alias.offset, 0)
        XCTAssertEqual(alias.length, 21)
        XCTAssertEqual(alias.children.count, 0)
    }

    // MARK: - Helpers

    func getTypealiasString() -> String {
        return """
        typealias Name = Type
        """
    }

    func getTypealiasData() -> [String: Any] { // Data must be built here manually because typeliases are not found in the structure (only when resolving)
        return [
            "key.filepath":  "/path/to/file.swift",
            "key.typename": "Type",
            "key.length": 21,
            "key.name": "Name",
            "key.kind": "source.lang.swift.ref.typealias",
            "key.offset": 0
        ]
    }
}
