import XCTest
import XcodeKit
@testable import XcodePluginProxy

class EndToEndTests: XCTestCase {

    // The test project is copied to the resources directory build phases
    let testProject = Bundle(for: EndToEndTests.self).resourcePath! + "/TestProject"

    func test_plugin() {
        let prefs = Preferences()
        prefs.automaticallyDetectProjectPath = false
        prefs.projectPath = URL(fileURLWithPath: testProject)
        XPCManager.setUpConnection()
        let command = TestCommand()
        let invocation = createCommandInvocation("KeywordsMock")
        let expected = getExpected("KeywordsMock")
        for _ in 0...0 {
            let s = DispatchSemaphore(value: 0)
            autoreleasepool {
                command.perform(with: invocation) { (error) in
                    XCTAssertNil(error)
                    XCTAssertEqual(invocation.sourceTextBuffer.completeBuffer, expected)
                    s.signal()
                }
            }
            s.wait()
        }
        print("fin")
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
