import XCTest
@testable import SwiftStructureInterface

class SwiftTypealiasBuilderTests: XCTestCase {

    // MARK: - build

    func test_build_shouldBuildTypealias() {
        let alias = SKElementFactory().build(data: getTypealiasData(), fileText: getTypealiasString()) as! Typealias
        XCTAssertEqual(alias.typeName, "Type")
    }

    func test_build_shouldBuildTypealiasShouldRemoveTypeFromClosures() {
        let alias = SKElementFactory().build(data: getTypealiasClosureData(), fileText: getTypealiasClosureString()) as! Typealias
        XCTAssertEqual(alias.typeName, "() -> ()")
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

    func getTypealiasClosureString() -> String {
        return """
        typealias Name = () -> ()
        """
    }

    func getTypealiasClosureData() -> [String: Any] { // Data must be built here manually because typeliases are not found in the structure (only when resolving)
        return [
            "key.filepath":  "/path/to/file.swift",
            "key.typename": "() -> ().Type",
            "key.length": 25,
            "key.name": "Name",
            "key.kind": "source.lang.swift.ref.typealias",
            "key.offset": 0
        ]
    }
}
