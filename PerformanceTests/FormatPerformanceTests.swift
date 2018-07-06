import XCTest
import TestHelper
import Algorithms
import AST

class FormatPerformanceTests: XCTestCase {
    
    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: FormatPerformanceTests.self).resourcePath! + "/TestProject"

    func test_nestedClassFormatPerformance() throws {
        let util = FormatUtil(useTabs: false, spaces: 4)
        let fileElement = try ParserTestHelper.parseFile(fromPath: testProject + "/NestedClassPerformanceTest.swift")
        let (contents, offset) = CaretTestHelper.findCaretOffset(fileElement.text)
        let lines = contents.components(separatedBy: "\n")
        let element = CaretUtil().findElementUnderCaret(in: fileElement, cursorOffset: Int(offset!), type: Declaration.self)!
        measure {
            _ = util.format(lines, relativeTo: element)
        }
    }
}
