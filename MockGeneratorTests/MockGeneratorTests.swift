import XCTest
@testable import MockGenerator

class MockGeneratorTests: XCTestCase {
    
    let testProject = "/Users/sean/source/plugins/MockGenerator/TestProject"
    
    func test_simpleMock() {
        let (mock, expected) = readMock(named: "SimpleProtocolMock")
        let result = CaretTestHelper.findCaretLineColumn(mock)
        let (lines, error) = Generator.generateMock(fromFileContents: result.contents, projectURL: URL(fileURLWithPath: testProject), line: result.lineColumn!.line, column: result.lineColumn!.column)
        XCTAssertNil(error)
        StringCompareTestHelper.assertEqualStrings(join(lines), expected)
    }
    
    // MARK: - Helpers
    
    private func readMock(named: String) -> (String, String) {
        let mock = try! String(contentsOfFile: testProject + "/" + named + ".swift")
        let expected = try! String(contentsOfFile: testProject + "/" + named + "_expected.swift")
        return (mock, expected)
    }

    private func join(_ lines: [String]?) -> String? {
        guard let lines = lines else { return nil }
        return lines.joined(separator: "\n")
    }
}
