import XCTest
@testable import MockGenerator

class MockGeneratorTests: XCTestCase {
    
    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: MockGeneratorTests.self).resourcePath! + "/TestProject"
    
    func test_generatesSimpleMock() {
        assertMockGeneratesExpected("SimpleProtocolMock")
    }

    func test_deletesMockBody() {
        assertMockGeneratesExpected("DeleteBodyMock")
    }

    func test_doesNotDeleteMockBody_whenMockGenerateFails() {
        assertMockGeneratesError("DoNotDeleteBodyMock", "Could not find a protocol on DoNotDeleteBodyMock")
    }

    func test_generatesReturnStubs() {
        assertMockGeneratesExpected("ReturnProtocolMock")
    }

    func test_generatesPropertyMock() {
        assertMockGeneratesExpected("PropertyProtocolMock")
    }

    func test_catchesMethodParameterInvocations() {
        assertMockGeneratesExpected("MethodParameterProtocolMock")
    }

    func test_addsDefaultValuesToStubsWherePossible() {
        assertMockGeneratesExpected("DefaultValuesMock")
    }

    func test_escapesKeywords() {
        assertMockGeneratesExpected("KeywordsMock")
    }

    func test_handlesOverloadedMethodsAndProperties() {
        assertMockGeneratesExpected("OverloadProtocolMock")
    }

    func test_closureSupport() {
        assertMockGeneratesExpected("ClosureProtocolMock")
    }

    func test_annotationSupport() {
        assertMockGeneratesExpected("ParameterAnnotationMock")
    }

    func test_typealiasSupport() {
        assertMockGeneratesExpected("TypealiasProtocolMock")
    }

    func test_handlesGenericMethods() {
        assertMockGeneratesExpected("GenericMethodMock")
    }

    func test_throwingSupport() {
        assertMockGeneratesExpected("ThrowingProtocolMock")
    }

    func test_protocolInitializer() {
        assertMockGeneratesExpected("InitialiserProtocolMock")
    }

    func test_multipleProtocol() {
        assertMockGeneratesExpected("MultipleProtocolMock")
    }

    func test_deepInheritance() {
        assertMockGeneratesExpected("DeepInheritanceMock")
    }

    func test_diamondInheritance() {
        assertMockGeneratesExpected("DiamondInheritanceProtocolMock")
    }

    func test_overloadingAcrossProtocols() {
        assertMockGeneratesExpected("RecursiveProtocolMock")
    }

    func test_generatesFromTupleTypes() {
        assertMockGeneratesExpected("TupleProtocolMock")
    }

    func test_generatesMockForAllCaretPositions() {
        let expected = readFile(named: "SimpleProtocolMock_expected.swift")
        let caretFile = readFile(named: "CaretSuccessTest.swift")
        var contentsLineColumn: (contents: String, lineColumn: (line: Int, column: Int)?) = (caretFile, nil)
        var caretLineColumns = [(line: Int, column: Int)]()
        repeat {
            contentsLineColumn = CaretTestHelper.findCaretLineColumn(contentsLineColumn.contents)
            if let lineColumn = contentsLineColumn.lineColumn {
                caretLineColumns.append(lineColumn)
            }
        } while contentsLineColumn.lineColumn != nil
        XCTAssertGreaterThan(caretLineColumns.count, 0)
        caretLineColumns.forEach { lineColumn in
            let (lines, error) = Generator.generateMock(fromFileContents: contentsLineColumn.contents, projectURL: URL(fileURLWithPath: testProject), line: lineColumn.line, column: lineColumn.column)
            XCTAssertNil(error, "Failed to generate mock from caret at line: \(lineColumn.line) column: \(lineColumn.column)")
            StringCompareTestHelper.assertEqualStrings(join(lines), expected)
        }
    }

    func test_generatesErrorForAllBadCaretPositions() {
        let caretFile = readFile(named: "CaretFailureTest.swift")
        var contentsLineColumn: (contents: String, lineColumn: (line: Int, column: Int)?) = (caretFile, nil)
        var caretLineColumns = [(line: Int, column: Int)]()
        repeat {
            contentsLineColumn = CaretTestHelper.findCaretLineColumn(contentsLineColumn.contents)
            if let lineColumn = contentsLineColumn.lineColumn {
                caretLineColumns.append(lineColumn)
            }
        } while contentsLineColumn.lineColumn != nil
        XCTAssertGreaterThan(caretLineColumns.count, 0)
        caretLineColumns.forEach { lineColumn in
            let (lines, error) = Generator.generateMock(fromFileContents: contentsLineColumn.contents, projectURL: URL(fileURLWithPath: testProject), line: lineColumn.line, column: lineColumn.column)
            XCTAssertNotNil(error, "Should not be generating a mock from caret at line: \(lineColumn.line) column: \(lineColumn.column)")
            XCTAssertNil(lines)
        }
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
    
    private func readMock(named fileName: String) -> (String, String) {
        let mock = readFile(named: fileName + ".swift")
        let expected = readFile(named: fileName + "_expected.swift")
        return (mock, expected)
    }

    private func readFile(named fileName: String) -> String {
        return try! String(contentsOfFile: testProject + "/" + fileName)
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
