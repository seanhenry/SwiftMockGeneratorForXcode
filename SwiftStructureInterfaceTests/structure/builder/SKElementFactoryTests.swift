import XCTest
import SourceKittenFramework
@testable import SwiftStructureInterface

class SKElementFactoryTests: XCTestCase {

    func test_badFilePath_returnsNil() {
        XCTAssertNil(SKElementFactory().build(fromPath: "nonexistent_file"))
    }
}
