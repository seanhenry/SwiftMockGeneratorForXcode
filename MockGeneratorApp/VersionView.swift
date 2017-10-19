import AppKit

class VersionView: NSTextField {

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        stringValue = VersionView.versionString
    }

    static var versionString: String {
        let name = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        return "\(name) v\(version)"
    }
}
