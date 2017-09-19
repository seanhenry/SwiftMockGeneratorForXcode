import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    private var cancelled = false
    fileprivate lazy var connection: Connection = {
        let connection = Connection()
        connection.setUpConnection()
        return connection
    }()
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) -> Void {
        invocation.cancellationHandler = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.cancelled = true
                self?.connection.suspendConnection()
            }
        }
        connection.interruptionHandler { [weak self] in
            self?.finish(with: self?.createError("The XPC service was interrupted"), handler: completionHandler)
        }
        connection.invalidationHandler { [weak self] in
            self?.connection.shutdownConnection()
            self?.finish(with: self?.createError("The XPC service was invalidated"), handler: completionHandler)
        }
        connection.resumeConnection()
        connection.remoteObjectProxyWithErrorHandler({ [weak self] proxy in
            self?.generateMock(proxy: proxy, invocation: invocation, completionHandler: completionHandler)
        }) { [weak self] error in
            self?.finish(with: error, handler: completionHandler)
        }
    }
    
    private func generateMock(proxy: MockGeneratorXPCProtocol, invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        let selections = invocation.buffer.selections
        guard selections.count > 0 else {
            finish(with: createError("No selections. Place the cursor within the class declaration"), handler: completionHandler)
            return
        }
        guard let range = selections.object(at: 0) as? XCSourceTextRange else {
            finish(with: createError("First selection was not a text range"), handler: completionHandler)
            return
        }
        guard let projectURL = Preferences().projectPath else {
            finish(with: createError("Set the project path in the Mock Generator companion app"), handler: completionHandler)
            return
        }
        let actualLineNumber = range.start.line + 1
        proxy.generateMock(fromFileContents: invocation.buffer.completeBuffer, projectURL: projectURL, line: actualLineNumber, column: range.start.column) { [weak self] (result, error) in
            DispatchQueue.main.async {
                self?.handleGenerateMock(invocation: invocation, result: result, error: error, completionHandler: completionHandler)
            }
        }
    }
    
    private func handleGenerateMock(invocation: XCSourceEditorCommandInvocation, result: [String]?, error: Error?, completionHandler: @escaping (Error?) -> Void) {
        if cancelled {
            finish(with: createError("The operation was cancelled"), handler: completionHandler)
            return
        }
        if let result = result {
            invocation.buffer.completeBuffer = result.joined(separator: "\n")
        }
        finish(with: error, handler: completionHandler)
    }
    
    private func finish(with error: Error?, handler: (Error?) -> ()) {
        connection.suspendConnection()
        handler(error)
    }
    
    private func createError(_ message: String) -> Error {
        return NSError(domain: "codes.seanhenry.mockgenerator", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
    
    fileprivate class Connection {
        
        static var connection: NSXPCConnection?
        static var isRunning = false
        private static let connectionQueue = DispatchQueue(label: "codes.seanhenry.mockgenerator.connectionQueue")
        
        func setUpConnection() {
            synchronise { _ in
                if Connection.connection == nil {
                    Connection.connection = NSXPCConnection(serviceName: "codes.seanhenry.MockGeneratorXPC")
                    Connection.connection?.remoteObjectInterface = NSXPCInterface(with: MockGeneratorXPCProtocol.self)
                    Connection.isRunning = false
                }
            }
        }
        
        func resumeConnection() {
            synchronise { connection in
                if !Connection.isRunning {
                    connection?.resume()
                    Connection.isRunning = true
                }
            }
        }
        
        func suspendConnection() {
            synchronise { connection in
                if Connection.isRunning {
                    connection?.suspend()
                    Connection.isRunning = false
                }
            }
        }
        
        func shutdownConnection() {
            synchronise { connection in
                connection?.suspend()
                connection?.invalidate()
                Connection.connection = nil
            }
        }
        
        func interruptionHandler(_ closure: @escaping () -> ()) {
            synchronise { connection in
                connection?.interruptionHandler = {
                    self.mainThread { closure() }
                }
            }
        }
        
        func invalidationHandler(_ closure: @escaping () -> ()) {
            synchronise { connection in
                connection?.invalidationHandler = {
                    self.mainThread { closure() }
                }
            }
        }
        
        func remoteObjectProxyWithErrorHandler(_ closure: @escaping (MockGeneratorXPCProtocol) -> (), _ errorHandler: @escaping (Error) -> ()) {
            synchronise { [weak self] connection in
                let proxy = connection?.remoteObjectProxyWithErrorHandler { [weak self] error in
                    self?.mainThread { errorHandler(error) }
                }
                if let mockGenerator = proxy as? MockGeneratorXPCProtocol {
                    self?.mainThread {
                        closure(mockGenerator)
                    }
                } else {
                    fatalError("XPCConnection is set up with the wrong protocol type")
                }
            }
        }
        
        func synchronise(_ closure: @escaping (NSXPCConnection?) -> ()) {
            Connection.connectionQueue.async {
                closure(Connection.connection)
            }
        }
        
        func mainThread(_ closure: @escaping () -> ()) {
            if Thread.isMainThread {
                closure()
                return
            }
            DispatchQueue.main.async {
                closure()
            }
        }
    }
}
