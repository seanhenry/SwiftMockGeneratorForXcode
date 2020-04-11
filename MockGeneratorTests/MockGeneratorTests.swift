import XCTest
import TestHelper
import SwiftyPluginTest
import SwiftyKit
import AST
@testable import MockGenerator

class MockGeneratorTests: XCTestCase {

    var trackedLines: Int?

    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: MockGeneratorTests.self).resourcePath! + "/TestProject"

    override func setUp() {
        super.setUp()
        formatterFactory = FormatterFactory { DefaultFormatter(useTabs: false, indentationWidth: 4) }
    }

    func test_generatesSimpleMock() {
        assertMockGeneratesExpected("SimpleProtocolMock")
    }

    func test_generatesSimpleMockWithTabs() {
        formatterFactory = FormatterFactory { DefaultFormatter(useTabs: true, indentationWidth: 4) }
        assertMockGeneratesExpected("TabSimpleProtocolMock")
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
        assertMockGeneratesError(contents: "class MockClass {<selection></selection>}", "MockClass must inherit from a class or implement at least 1 protocol")
    }

    func test_generatesMockForAllCaretPositions() throws {
        let testFiles = [
            "CaretSuccessTest-1.swift",
            "CaretSuccessTest-2.swift",
            "CaretSuccessTest-3.swift",
            "CaretSuccessTest-4.swift",
        ]
        try testFiles.forEach {
            let file = readFile(named: $0)
            let buffer = try TestTextBuffer.builder(buffer: file)
                .findSelections()
                .build()
            _ = try Generator(
                projectURL: URL(fileURLWithPath: testProject),
                templateName: "spy",
                trackLines: { self.trackedLines = $0 }
            ).execute(buffer: buffer)
        }
    }

    func test_generatesErrorForAllBadCaretPositions() throws {
        let testFiles = [
            "CaretFailureTest-1.swift",
            "CaretFailureTest-2.swift",
            "CaretFailureTest-3.swift",
            "CaretFailureTest-4.swift",
        ]
        try testFiles.forEach {
            let file = readFile(named: $0)
            let buffer = try TestTextBuffer.builder(buffer: file)
                .findSelections()
                .build()
            do {
                _ = try Generator(
                    projectURL: URL(fileURLWithPath: testProject),
                    templateName: "spy",
                    trackLines: { self.trackedLines = $0 }
                ).execute(buffer: buffer)
            } catch {
                return
            }
            XCTFail("Should not be generating a mock from caret in file '\($0)'")
        }
    }

    func test_supportsFoldersWithSpacesInTheirSpace() {
        assertMockGeneratesExpected("Test Folder With Spaces/FolderSpacesMock")
    }

    func test_tracksNumberOfGeneratedLines() {
        assertMockGeneratesExpected("SimpleProtocolMock")
        XCTAssertEqual(trackedLines, 6)
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
        do {
            let buffer = try TestTextBuffer.builder(buffer: mock)
                .findSelections()
                .build()
            let generator = Generator(
                projectURL: URL(fileURLWithPath: testProject),
                templateName: templateName,
                trackLines: { self.trackedLines = $0 }
            )
            let result = try CommandTestHelper().execute(buffer: buffer, command: generator)
            return (result.lines, nil)
        } catch {
            return (nil, error)
        }
    }


    private func join(_ lines: [String]?) -> String? {
        guard let lines = lines else { return nil }
        return lines.joined()
    }
}
