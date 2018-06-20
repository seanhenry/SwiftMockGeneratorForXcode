import XCTest
@testable import SwiftStructureInterface

class FormatPerformanceTests: XCTestCase {
    
    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: FormatPerformanceTests.self).resourcePath! + "/TestProject"

    func test_formatPerformance() {
        var result: String?
        let expected = try! String(contentsOfFile: testProject + "/KeywordsMock_expected.swift")
        measure {
            result = try! SKFormatRequest().format(filePath: testProject + "/KeywordsMock_unformatted.swift")
        }
        XCTAssertEqual(result, expected)
    }
}
