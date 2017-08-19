//
//  SourceEditorCommand.swift
//  XcodePlugin
//
//  Created by Sean Henry on 12/08/2017.
//  Copyright © 2017 Sean Henry. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    lazy var connection: NSXPCConnection! = {
        let connection = NSXPCConnection(serviceName: "codes.seanhenry.MockGeneratorXPC")
        connection.remoteObjectInterface = NSXPCInterface(with: MockGeneratorXPCProtocol.self)
        connection.resume()
        return connection
    }()
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let proxy = self.connection.remoteObjectProxyWithErrorHandler { error in
            print(error)
            self.finish(with: error, handler: completionHandler)
        } as! MockGeneratorXPCProtocol
        let range = invocation.buffer.selections.object(at: 0) as! XCSourceTextRange
        proxy.generateMock(fromFileContents: invocation.buffer.completeBuffer, projectURL: Preferences().projectPath!, line: range.start.line, column: range.start.column, withReply: { (result, error) in
            DispatchQueue.main.async {
                print("\(String(describing: result)) \(String(describing: error))")
                if let result = result {
                    self.deleteClassBody(invocation: invocation)
                    invocation.buffer.lines.addObjects(from: result)
                    invocation.buffer.lines.add("")
                    invocation.buffer.lines.add("}")
                }
                self.finish(with: error, handler: completionHandler)
            }
        })
    }
    
    private func deleteClassBody(invocation: XCSourceEditorCommandInvocation) {
        let range = invocation.buffer.selections.object(at: 0) as! XCSourceTextRange
        let cursorLine = range.start.line
        let deletionLine = cursorLine + 1
        invocation.buffer.lines.removeObjects(in: NSRange(location: deletionLine, length: invocation.buffer.lines.count - deletionLine))
        
    }
    
    private func finish(with error: Error?, handler: (Error?) -> ()) {
        connection.invalidate()
        connection = nil
        handler(error)
    }
    
}
