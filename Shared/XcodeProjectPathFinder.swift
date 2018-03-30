import Foundation
import AppleScriptObjC

class XcodeProjectPathFinder {

    func findOpenProjectPath() -> URL? {
        if let workspace = findOpenWorkspacePath(), workspace.hasPrefix("/") {
            return URL(fileURLWithPath: workspace).deletingLastPathComponent()
        }
        return nil
    }

    func findOpenWorkspacePath() -> String? {
        precondition(Thread.isMainThread, "NSAppleScript must be run on the main thread.")
        let script = NSAppleScript(source: "tell application \"Xcode\" to path of active workspace document")
        return script?.executeAndReturnError(nil).stringValue
    }
}
