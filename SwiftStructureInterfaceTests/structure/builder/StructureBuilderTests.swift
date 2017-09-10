import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class StructureBuilderTests: XCTestCase {

    func test_badFilePath_returnsNil() {
        XCTAssertNil(StructureBuilder().build(fromPath: "nonexistent_file"))
    }
}
