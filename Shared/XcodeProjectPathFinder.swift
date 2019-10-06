import Foundation
import AppleScriptObjC

class XcodeProjectPathFinder {

    func findOpenProjectPath() -> URL? {
        if let workspace = findOpenWorkspacePath(), workspace.hasPrefix("/") {
            return URL(fileURLWithPath: workspace)
        }
        return nil
    }

    func findOpenWorkspacePath() -> String? {
        precondition(Thread.isMainThread, "NSAppleScript must be run on the main thread.")
        let script = NSAppleScript(source: """
        if application id "com.apple.dt.Xcode" is running then
          tell application id "com.apple.dt.Xcode" to path of active workspace document
        end if
        """)
        return script?.executeAndReturnError(nil).stringValue
    }
}
