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
        proxy.test() { string in
            print(String(describing: string))
            self.finish(with: nil, handler: completionHandler)
        }
    }
    
    private func finish(with error: Error?, handler: (Error?) -> ()) {
        connection.invalidate()
        connection = nil
        handler(error)
    }
    
}
