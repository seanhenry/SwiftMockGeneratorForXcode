import XCTest
@testable import SwiftStructureInterface

class FormatPerformanceTests: XCTestCase {
    
    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: FormatPerformanceTests.self).resourcePath! + "/TestProject"

    func test_formatPerformance() { // 0.503
        var result: String?
        let expected = try! String(contentsOfFile: testProject + "/KeywordsMock_expected.swift")
        measure {
            result = try! SKFormatRequest().format(filePath: testProject + "/KeywordsMock_unformatted.swift")
        }
        XCTAssertEqual(result, expected)
    }

    func test_nestedClassFormatPerformance() { // 0.006
        let util = FormatUtil(useTabs: false, spaces: 4)
        let fileElement = SKElementFactoryTestHelper.build(fromPath: testProject + "/NestedClassPerformanceTest.swift")!
        let (contents, offset) = CaretTestHelper.findCaretOffset(fileElement.text)
        let lines = contents.components(separatedBy: "\n")
        let element = CaretUtil().findElementUnderCaret(in: fileElement, cursorOffset: offset!)!
        measure {
            _ = util.format(lines, in: element)
        }
    }

    func test_nestedClassFormatPerformance_withSourceKit() { // 0.6
        measure {
            _ = try! SKFormatRequest().format(filePath: testProject + "/NestedClassPerformanceTest.swift")
        }
    }
}
