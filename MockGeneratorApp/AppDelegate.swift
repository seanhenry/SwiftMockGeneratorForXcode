import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        Analytics.initCrashlytics()
        let name = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        NSApplication.shared.windows.forEach { window in
            window.title = name
            window.setContentSize(NSSize(width: 600, height: 286))
            window.contentMinSize = NSSize(width: 600, height: 286)
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
