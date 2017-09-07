import XCTest
@testable import MockGenerator

class MockGeneratorTests: XCTestCase {
    
    let testProject = "/Users/sean/source/plugins/MockGenerator/TestProject"
    
    func test_generatesSimpleMock() {
        assertMockGeneratesExpected("SimpleProtocolMock")
    }

    func test_deletesMockBody() {
        assertMockGeneratesExpected("DeleteBodyMock")
    }

    func test_doesNotDeleteMockBody_whenMockGenerateFails() {
        assertMockGeneratesError("DoNotDeleteBodyMock", "NotAValidProtocol element could not be resolved")
    }

    func test_generatesReturnStubs() {
        assertMockGeneratesExpected("ReturnProtocolMock")
    }

    func test_generatesPropertyMock() {
        assertMockGeneratesExpected("PropertyProtocolMock")
    }

    // MARK: - Helpers

    private func assertMockGeneratesExpected(_ fileName: String, line: UInt = #line) {
        let (mock, expected) = readMock(named: fileName)
        assertMock(mock, generates: expected, line: line)
    }

    private func assertMockGeneratesError(_ fileName: String, _ expectedError: String, line: UInt = #line) {
        let mock = try! String(contentsOfFile: testProject + "/" + fileName + ".swift")
        let (lines, error) = generateMock(mock)
        XCTAssertNil(lines, line: line)
        let nsError = error as NSError?
        XCTAssertEqual(nsError?.localizedDescription, expectedError, line: line)
    }
    
    private func readMock(named: String) -> (String, String) {
        let mock = try! String(contentsOfFile: testProject + "/" + named + ".swift")
        let expected = try! String(contentsOfFile: testProject + "/" + named + "_expected.swift")
        return (mock, expected)
    }

    private func assertMock(_ mock: String, generates expected: String, line: UInt = #line) {
        let (lines, error) = generateMock(mock)
        XCTAssertNil(error, line: line)
        StringCompareTestHelper.assertEqualStrings(join(lines), expected, line: line)
    }

    private func generateMock(_ mock: String) -> ([String]?, Error?) {
        let result = CaretTestHelper.findCaretLineColumn(mock)
        return Generator.generateMock(fromFileContents: result.contents, projectURL: URL(fileURLWithPath: testProject), line: result.lineColumn!.line, column: result.lineColumn!.column)
    }

    private func join(_ lines: [String]?) -> String? {
        guard let lines = lines else { return nil }
        return lines.joined(separator: "\n")
    }
}
