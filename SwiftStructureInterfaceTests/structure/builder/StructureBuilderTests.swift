import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class StructureBuilderTests: XCTestCase {

    // MARK: - build
// TODO: what should actually happen here?
    func test_build_shouldNotCrash_whenStringIsSmallerThanTheDataProvided() {
        _ = StructureBuilder(data: Structure(file: File(contents: "protocol P {}")).dictionary, fileText: "").build() // should not crash
    }

    // MARK: - Helpers


}
