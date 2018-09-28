import Foundation
import XcodeKit

open class BaseCommand: NSObject, XCSourceEditorCommand {
    
    private weak var invocation: SourceEditorCommandInvocation?

    open var templateName: String {
        fatalError("override me")
    }

    private var connection: Connection {
        return XPCManager.connection!
    }
    
    public func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        perform(with: invocation as SourceEditorCommandInvocation, completionHandler: completionHandler)
    }
    
    func perform(with invocation: SourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        self.invocation = invocation
        setCancelHandler(invocation, completionHandler)
        connection.remoteObjectProxyWithErrorHandler({ [weak self] proxy in
            self?.setErrorHandlers(completionHandler)
            self?.generateMock(proxy: proxy, invocation: invocation, completionHandler: completionHandler)
        }) { [weak self] error in
            self?.finish(with: error, handler: completionHandler)
        }
    }

    private func setCancelHandler(_ invocation: SourceEditorCommandInvocation, _ completionHandler: @escaping (Error?) -> Void) {
        invocation.cancellationHandler = { [weak self] in
            self?.finish(with: self?.createError("The operation was cancelled"), handler: completionHandler)
        }
    }

    private func setErrorHandlers(_ completionHandler: @escaping (Error?) -> Void) {
        connection.interruptionHandler { [weak self] in
            self?.finish(with: self?.createError("There was an unexpected error. Try again or raise an issue on GitHub"), handler: completionHandler)
        }
        connection.invalidationHandler { [weak self] in
            self?.finish(with: self?.createError("The XPC service was invalidated"), handler: completionHandler)
        }
    }

    private func finish(with error: Error?, handler: @escaping (Error?) -> ()) {
        connection.interruptionHandler {}
        connection.invalidationHandler {}
        DispatchQueue.main.async {
            self.invocation?.cancellationHandler = {} // remove retain cycle
            self.track(error)
            handler(error)
        }
    }

    private func getProjectURLOnMainThread() throws -> URL {
        if Thread.isMainThread {
            return try getProjectURL()
        }
        return try DispatchQueue.main.sync {
            return try getProjectURL()
        }
    }

    private func getProjectURL() throws -> URL {
        return try ProjectFinder(projectFinder: XcodeProjectPathFinder(), preferences: Preferences())
            .getProjectPath()
    }
    
    private func generateMock(proxy: MockGeneratorXPCProtocol, invocation: SourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        do {
            let projectURL = try getProjectURLOnMainThread()
            try tryToGenerateMock(atProjectURL: projectURL, proxy: proxy, invocation: invocation) { [weak self] (result, error) in
                self?.handleGenerateMock(invocation: invocation, result: result, error: error, completionHandler: completionHandler)
            }
        } catch {
            finish(with: error, handler: completionHandler)
        }
    }

    private func tryToGenerateMock(atProjectURL projectURL: URL, proxy: MockGeneratorXPCProtocol, invocation: SourceEditorCommandInvocation, completionHandler: @escaping (XPCBufferInstructions?, Error?) -> Void) throws {
        let range = try getRange(selections: try getSelection(invocation: invocation))
        let actualLineNumber = range.start.line + 1
        let model = XPCMockGeneratorModel(
                contents: invocation.sourceTextBuffer.completeBuffer,
                projectURL: projectURL,
                line: actualLineNumber,
                column: range.start.column,
                templateName: templateName,
                usesTabsForIndentation: invocation.sourceTextBuffer.usesTabsForIndentation,
                indentationWidth: invocation.sourceTextBuffer.indentationWidth
        )
        proxy.generateMock(from: model, withReply: completionHandler)
    }

    private func getSelection(invocation: SourceEditorCommandInvocation) throws -> NSMutableArray {
        let selections = invocation.sourceTextBuffer.selections
        guard selections.count > 0 else {
            throw createError("No selections. Place the cursor within the class declaration")
        }
        return selections
    }

    private func getRange(selections: NSMutableArray) throws -> XCSourceTextRange {
        guard let range = selections.object(at: 0) as? XCSourceTextRange else {
            throw createError("First selection was not a text range")
        }
        return range
    }

    private func handleGenerateMock(invocation: SourceEditorCommandInvocation, result: XPCBufferInstructions?, error: Error?, completionHandler: @escaping (Error?) -> Void) {
        if let result = result {
            DispatchQueue.main.async {
                let bufferEditor = BufferEditor()
                bufferEditor.delete(from: result.deleteIndex, length: result.deleteLength, in: invocation.sourceTextBuffer.lines)
                bufferEditor.insert(result.linesToInsert, into: invocation.sourceTextBuffer.lines, at: result.insertIndex)
            }
            track(result)
        }
        finish(with: error, handler: completionHandler)
    }

    private func track(_ instructions: XPCBufferInstructions?) {
        let tracker = GoogleAnalyticsTracker()
        if let insertCount = instructions?.linesToInsert.count {
            tracker.track(category: templateName, action: "generated", value: insertCount)
            Analytics.track(templateName, attributes: ["lines": insertCount])
        }
    }

    private func track(_ error: Error?) {
        let tracker = GoogleAnalyticsTracker()
        if let error = error {
            let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            tracker.track(category: templateName, action: "\(version)_\(error.localizedDescription)")
            Analytics.track("error", attributes: ["version": version, "description": error.localizedDescription])
        }
    }
    
    private func createError(_ message: String) -> Error {
        return NSError(domain: "codes.seanhenry.mockgenerator", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
