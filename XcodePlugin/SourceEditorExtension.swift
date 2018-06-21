import Foundation
import XcodeKit
import Cocoa
import XcodePluginProxy

class SourceEditorExtension: NSObject, XCSourceEditorExtension {

    func extensionDidFinishLaunching() {
        XPCManager.setUpConnection()
    }
}
