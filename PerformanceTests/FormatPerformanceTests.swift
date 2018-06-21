import XCTest
@testable import SwiftStructureInterface

class FormatPerformanceTests: XCTestCase {
    
    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: FormatPerformanceTests.self).resourcePath! + "/TestProject"

    func test_formatPerformance() { // 0.819
        var result: String?
        let expected = try! String(contentsOfFile: testProject + "/KeywordsMock_expected.swift")
        measure {
            result = try! SKFormatRequest().format(filePath: testProject + "/KeywordsMock_unformatted.swift")
        }
        XCTAssertEqual(result, expected)
    }

    func test_nestedClassFormatPerformance() { // 1.34
        measure {
            _ = try! SKFormatRequest().format(filePath: testProject + "/NestedClassPerformanceTest.swift")
        }
    }
}
