import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        let name = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        NSApplication.shared.windows.forEach { window in
            var mask = window.styleMask
            mask.remove(.resizable)
            window.styleMask = mask
            window.title = name
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
