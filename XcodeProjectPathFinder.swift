import Foundation
import AppleScriptObjC

class XcodeProjectPathFinder {

    func findOpenProjectPath() -> String? {
        if let workspace = findOpenWorkspacePath(), workspace.hasPrefix("/") {
            return URL(fileURLWithPath: workspace).deletingLastPathComponent().path
        }
        return nil
    }

    func findOpenWorkspacePath() -> String? {
        let script = NSAppleScript(source: "tell application \"Xcode\" to path of active workspace document")
        return script?.executeAndReturnError(nil).stringValue
    }
}
