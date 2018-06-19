import XCTest
@testable import SwiftStructureInterface

class FormatPerformanceTests: XCTestCase {

    func test_formatPerformance() {
        var result: String?
        let expected = try! String(contentsOfFile: testProject + "/KeywordsMock_expected.swift")
        measure {
            result = try! SKFormatRequest().format(filePath: testProject + "/KeywordsMock_unformatted.swift")
        }
        XCTAssertEqual(result, expected)
    }
}
