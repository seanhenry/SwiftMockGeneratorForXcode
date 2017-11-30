import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SKElementFactoryTests: XCTestCase {

    func test_badFilePath_returnsNil() {
        XCTAssertNil(SKElementFactory().build(fromPath: "nonexistent_file"))
    }

    func test_build_returnsNil_whenStructureFailsToLoadFromContents() {
        SKElementFactory.structureRequest = ThrowingStructureRequest()
        XCTAssertNil(SKElementFactory().build(from: ""))
        SKElementFactory.structureRequest = SKStructureRequest()
    }

    func test_build_returnsNil_whenStructureFailsToLoadFromFile() {
        SKElementFactory.structureRequest = ThrowingStructureRequest()
        XCTAssertNil(SKElementFactory().build(fromPath: ""))
        SKElementFactory.structureRequest = SKStructureRequest()
    }

    // MARK: - Helpers

    class ThrowingStructureRequest: StructureRequest {
        class Error: Swift.Error {}
        func getStructure(contents: String) throws -> [String: Any] {
            throw Error()
        }
        func getStructure(filePath: String) throws -> ([String: Any], String) {
            throw Error()
        }
    }
}
