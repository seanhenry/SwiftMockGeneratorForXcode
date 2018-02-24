import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {

    fileprivate var connection: Connection = {
        let connection = Connection()
        connection.connection = SourceEditorExtension.connection!
        return connection
    }()

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        setCancelHandler(invocation, completionHandler)
        setErrorHandlers(completionHandler)
        connection.resumeConnection()
        connection.remoteObjectProxyWithErrorHandler({ [weak self] proxy in
            self?.generateMock(proxy: proxy, invocation: invocation, completionHandler: completionHandler)
        }) { [weak self] error in
            self?.finish(with: error, handler: completionHandler)
        }
    }

    private func setCancelHandler(_ invocation: XCSourceEditorCommandInvocation, _ completionHandler: @escaping (Error?) -> Void) {
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
        connection.suspendConnection()
        handler(error)
    }
    
    private func generateMock(proxy: MockGeneratorXPCProtocol, invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        do {
            try tryToGenerateMock(proxy: proxy, invocation: invocation) { [weak self] (result, error) in
                self?.handleGenerateMock(invocation: invocation, result: result, error: error, completionHandler: completionHandler)
            }
        } catch {
            finish(with: error, handler: completionHandler)
        }
    }

    private func tryToGenerateMock(proxy: MockGeneratorXPCProtocol, invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping ([String]?, Error?) -> Void) throws {
        let range = try getRange(selections: try getSelection(invocation: invocation))
        let actualLineNumber = range.start.line + 1
        proxy.generateMock(fromFileContents: invocation.buffer.completeBuffer, line: actualLineNumber, column: range.start.column, withReply: completionHandler)
    }

    private func getSelection(invocation: XCSourceEditorCommandInvocation) throws -> NSMutableArray {
        let selections = invocation.buffer.selections
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

    private func handleGenerateMock(invocation: XCSourceEditorCommandInvocation, result: [String]?, error: Error?, completionHandler: @escaping (Error?) -> Void) {
        if let result = result {
            invocation.buffer.completeBuffer = result.joined(separator: "\n")
        }
        finish(with: error, handler: completionHandler)
    }
    
    private func createError(_ message: String) -> Error {
        return NSError(domain: "codes.seanhenry.mockgenerator", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
    
    fileprivate class Connection {
        
        var connection: NSXPCConnection?

        func resumeConnection() {
            connection?.resume()
        }

        func suspendConnection() {
            connection?.suspend()
        }
        
        func interruptionHandler(_ closure: @escaping () -> ()) {
            connection?.interruptionHandler = closure
        }

        func invalidationHandler(_ closure: @escaping () -> ()) {
            connection?.invalidationHandler = closure
            SourceEditorExtension.setUpConnection()
        }
        
        func remoteObjectProxyWithErrorHandler(_ closure: @escaping (MockGeneratorXPCProtocol) -> (), _ errorHandler: @escaping (Error) -> ()) {
            let proxy = connection?.remoteObjectProxyWithErrorHandler { error in
                errorHandler(error)
            }
            if let generator = proxy as? MockGeneratorXPCProtocol {
                closure(generator)
            } else {
                errorHandler(NSError(domain: "codes.seanhenry.mockgenerator", code: 0, userInfo: [NSLocalizedDescriptionKey: "The XPC service failed to return a proxy."]))
            }
        }
    }
}
