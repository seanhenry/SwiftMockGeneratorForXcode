import XCTest
import TestHelper
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

    func test_generatesSimpleClass() {
        assertMockGeneratesExpected("SimpleClassMock")
    }

    func test_generatesClassMockWithThrowingMembers() {
        assertMockGeneratesExpected("ThrowingClassMock")
    }

    func test_generatesClassMockInheritingAnotherClass() {
        assertMockGeneratesExpected("SuperclassMock")
    }

    func test_choosesSimplestInitializerForClassMock() {
        assertMockGeneratesExpected("MultipleInitializerClassMock")
    }

    func test_generatesInitializerWithArgumentsForClassMock() {
        assertMockGeneratesExpected("ArgumentInitializerClassMock")
    }

    func test_generatesMembersFromClassesAndProtocols() {
        assertMockGeneratesExpected("ClassAndProtocolMock")
    }

    func test_handlesEmptyFailableInitializerForClassMock() {
        assertMockGeneratesExpected("EmptyFailableInitializerClassMock")
    }

    func test_handlesFailableInitializerForClassMock() {
        assertMockGeneratesExpected("FailableInitializerClassMock")
    }

    func test_handlesAvailableAttributeForClassMock() {
        assertMockGeneratesExpected("AvailableClassMock")
    }

    func test_handlesClassRequiredInitializers() {
        assertMockGeneratesExpected("RequiredInitializerClassMock")
    }

    func test_handlesClassPrivateInitializers() {
        assertMockGeneratesExpected("PrivateInitializerClassMock")
    }

    func test_supportsClassProperties() {
        assertMockGeneratesExpected("PropertyClassMock")
    }

    func test_stripsModifiers() {
        assertMockGeneratesExpected("ModifierClassMock")
    }

    func test_supportsDefaultArgumentsInMethods() {
        assertMockGeneratesExpected("DefaultArgumentClassMock")
    }

    func test_supportsUTF32Characters() {
        assertMockGeneratesExpected("UTFMock")
    }

    func test_doesNotOverrideInvisibleMembers() {
        assertMockGeneratesError(fileName: "UnoverridableClassMock", "Found inherited types but there was nothing to mock")
    }

    func test_supportsInferredTypeVariableDeclarations() {
        assertMockGeneratesExpected("InferredTypeClassMock")
    }

    func test_doesNotYetSupportMultipleVariableDeclarations() {
        assertMockGeneratesExpected("MultipleVariableMock")
    }

    func test_readOnlySubscript() {
        assertMockGeneratesExpected("ReadOnlySubscriptProtocolMock")
    }

    func test_readWriteSubscript() {
        assertMockGeneratesExpected("SubscriptProtocolMock")
    }

    func test_subscriptWithArguments() {
        assertMockGeneratesExpected("ArgumentsSubscriptProtocolMock")
    }

    func test_subscriptWithOverloads() {
        assertMockGeneratesExpected("OverloadedSubscriptProtocolMock")
    }

    func test_subscriptInClass() {
        assertMockGeneratesExpected("ClassSubscriptMock")
    }
    
    func test_overriddenSubscripts() {
        assertMockGeneratesExpected("AugmentedClassSubscriptMock")
    }

    func test_generatesAPartialSpy() {
        assertMockGeneratesExpected("PartialSpyClassMock", templateName: "partial")
    }

    func test_shouldFilterNSObject() {
        assertMockGeneratesError(fileName: "NSObjectClassMock", "Found inherited types but there was nothing to mock")
    }

    func test_doesNotDeleteMockBody_whenMockGenerateFails() {
        assertMockGeneratesError(fileName: "DoNotDeleteBodyMock", "Could not find a class or protocol on DoNotDeleteBodyMock")
    }

    func test_returnsErrorWhenMockClassDoesNotInheritFromAnything() {
        assertMockGeneratesError(contents: "class MockClass {<caret>}", "MockClass must inherit from a class or implement at least 1 protocol")
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
            let file = try! String(contentsOfFile: testProject + "/SimpleProtocolMock.swift")
            let (lines, error) = generateMock(file)
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
            let (lines, error) = Generator(fromFileContents: contentsLineColumn.contents, projectURL: URL(fileURLWithPath: testProject), line: lineColumn.line, column: lineColumn.column, templateName: "spy", useTabsForIndentation: false, indentationWidth: 4).generateMock()
            XCTAssertNotNil(error, "Should not be generating a mock from caret at line: \(lineColumn.line) column: \(lineColumn.column)")
            XCTAssertNil(lines)
        }
    }

    func test_supportsFoldersWithSpacesInTheirSpace() {
        assertMockGeneratesExpected("Test Folder With Spaces/FolderSpacesMock")
    }

    // MARK: - Helpers

    private func assertMockGeneratesExpected(_ fileName: String, templateName: String = "spy", line: UInt = #line) {
        let (mock, expected) = readMock(named: fileName)
        assertMock(mock, generates: expected, templateName: templateName, line: line)
    }

    private func assertMockGeneratesError(fileName: String, _ expectedError: String, line: UInt = #line) {
        let contents = try! String(contentsOfFile: testProject + "/" + fileName + ".swift")
        assertMockGeneratesError(contents: contents, expectedError, line: line)
    }

    private func assertMockGeneratesError(contents: String, _ expectedError: String, line: UInt = #line) {
        let (lines, error) = generateMock(contents)
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

    private func assertMock(_ mock: String, generates expected: String, templateName: String = "spy", line: UInt = #line) {
        let (lines, error) = generateMock(mock, templateName: templateName)
        XCTAssertNil(error, line: line)
        StringCompareTestHelper.assertEqualStrings(join(lines), expected, line: line)
    }

    private func generateMock(_ mock: String, templateName: String = "spy") -> ([String]?, Error?) {
        let result = CaretTestHelper.findCaretLineColumn(mock)
        let (instructions, error) = Generator(fromFileContents: result.contents,
                                      projectURL: URL(fileURLWithPath: testProject),
                                      line: result.lineColumn!.line,
                                      column: result.lineColumn!.column,
                                      templateName: templateName,
                                      useTabsForIndentation: false,
                                      indentationWidth: 4).generateMock()
        return (applyInstructions(instructions, to: result.contents), error)
    }

    private func applyInstructions(_ instructions: BufferInstructions?, to contents: String) -> [String]? {
        guard let instructions = instructions else {
            return nil
        }
        var lines = split(contents)
        lines.removeSubrange(instructions.deleteIndex..<instructions.deleteIndex+instructions.deleteLength)
        lines.insert(contentsOf: instructions.linesToInsert, at: instructions.insertIndex)
        return lines
    }

    private func split(_ contents: String) -> [String] {
        var lines = contents.components(separatedBy: "\n")
        lines = lines.enumerated().map { (i, line) in
            if i == lines.count-1 {
                return line
            }
            return "\(line)\n"
        }
        return lines
    }

    private func join(_ lines: [String]?) -> String? {
        guard let lines = lines else { return nil }
        return lines.joined()
    }
}
