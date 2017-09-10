import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SwiftFileBuilderTests: XCTestCase {

    func test_build_shouldReturnFileWithoutElements_whenPassedTheWrongFileText() {
        let file = SKElementFactory().build(data: Structure(file: File(contents: "protocol P {}")).dictionary, fileText: "")
        XCTAssertEqual(file.children.count, 0)
    }
}
