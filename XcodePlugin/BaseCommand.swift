import Foundation
import XcodeKit

open class BaseCommand: NSObject, XCSourceEditorCommand {

    open var templateName: String {
        fatalError("override me")
    }

    private var connection: Connection {
        return XPCManager.connection!
    }
    
    public func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        self.perform(with: invocation as SourceEditorCommandInvocation, completionHandler: completionHandler)
    }
    
    func perform(with invocation: SourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        setCancelHandler(invocation, completionHandler)
        setErrorHandlers(completionHandler)
        connection.remoteObjectProxyWithErrorHandler({ [weak self] proxy in
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
            self?.finish(with: self?.createError("The XPC service was interrupted"), handler: completionHandler)
        }
        connection.invalidationHandler { [weak self] in
            self?.finish(with: self?.createError("The XPC service was invalidated"), handler: completionHandler)
        }
    }

    private func finish(with error: Error?, handler: (Error?) -> ()) {
        track(error)
        handler(error)
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

    private func tryToGenerateMock(atProjectURL projectURL: URL, proxy: MockGeneratorXPCProtocol, invocation: SourceEditorCommandInvocation, completionHandler: @escaping ([String]?, Error?) -> Void) throws {
        let range = try getRange(selections: try getSelection(invocation: invocation))
        let actualLineNumber = range.start.line + 1
        proxy.generateMock(fromFileContents: invocation.sourceTextBuffer.completeBuffer, projectURL: projectURL, line: actualLineNumber, column: range.start.column, templateName: templateName, withReply: completionHandler)
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

    private func handleGenerateMock(invocation: SourceEditorCommandInvocation, result: [String]?, error: Error?, completionHandler: @escaping (Error?) -> Void) {
        track(result)
        if let result = result {
            invocation.sourceTextBuffer.completeBuffer = result.joined(separator: "\n")
        }
        finish(with: error, handler: completionHandler)
    }

    private func track(_ lines: [String]?) {
        let tracker = GoogleAnalyticsTracker()
        if let lines = lines {
            tracker.track(category: templateName, action: "generated", value: lines.count)
        }
    }

    private func track(_ error: Error?) {
        let tracker = GoogleAnalyticsTracker()
        if let error = error {
            tracker.track(category: templateName, action: error.localizedDescription)
        }
    }
    
    private func createError(_ message: String) -> Error {
        return NSError(domain: "codes.seanhenry.mockgenerator", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
