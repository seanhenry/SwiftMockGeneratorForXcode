import XCTest
import XcodeKit
@testable import XcodePluginProxy

class EndToEndTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        let prefs = Preferences()
        prefs.automaticallyDetectProjectPath = false
        prefs.projectPath = URL(fileURLWithPath: testProject)
        XPCManager.setUpConnection()
    }

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

    func assertMockGeneratesExpected(_ fileName: String) {
        let command = TestCommand()
        let invocation = createCommandInvocation(fileName)
        let expected = getExpected(fileName)
        measure {
            let s = DispatchSemaphore(value: 0)
            command.perform(with: invocation) { (error) in
                XCTAssertNil(error)
                XCTAssertEqual(invocation.sourceTextBuffer.completeBuffer, expected)
                s.signal()
            }
            s.wait()
        }
    }

    private func getExpected(_ fileName: String) -> String {
        return readFile(named: fileName + "_expected.swift")
    }

    private func createCommandInvocation(_ fileName: String) -> SourceEditorCommandInvocation {
        let contents = readFile(named: fileName + ".swift")
        let contentsLineColumn = CaretTestHelper.findCaretLineColumn(contents)
        let (line, column) = contentsLineColumn.lineColumn!
        let selection = XCSourceTextRange(start: XCSourceTextPosition(line: line - 1, column: column), end: XCSourceTextPosition(line: line, column: column))
        let buffer = SourceTextBufferStub(buffer: contentsLineColumn.contents, selections: NSMutableArray(object: selection))
        let stub = CommandInvocationStub(buffer: buffer)
        return stub
    }

    private func readFile(named fileName: String) -> String {
        return try! String(contentsOfFile: testProject + "/" + fileName)
    }

    class TestCommand: BaseCommand {
        override var templateName: String {
            return "spy"
        }
    }

    class SourceTextBufferStub: SourceTextBuffer {
        var selections: NSMutableArray = NSMutableArray()
        var completeBuffer: String = ""

        init(buffer: String, selections: NSMutableArray) {
            self.completeBuffer = buffer
            self.selections = selections
        }
    }

    class CommandInvocationStub: SourceEditorCommandInvocation {
        var commandIdentifier: String = "test"
        var sourceTextBuffer: SourceTextBuffer
        var cancellationHandler: () -> () = {}

        init(buffer: SourceTextBuffer) {
            self.sourceTextBuffer = buffer
        }
    }
}
