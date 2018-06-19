import Foundation
import XcodeKit
import Cocoa

class SourceEditorExtension: NSObject, XCSourceEditorExtension {

    static var connection: NSXPCConnection!

    static func setUpConnection() {
        connection = NSXPCConnection(serviceName: "codes.seanhenry.MockGeneratorXPC")
        connection?.remoteObjectInterface = NSXPCInterface(with: MockGeneratorXPCProtocol.self)
    }

    func extensionDidFinishLaunching() {
        SourceEditorExtension.setUpConnection()
    }
}
