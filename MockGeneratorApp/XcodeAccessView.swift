import AppKit

class XcodeAccessView: NSView {
    @IBOutlet var messageField: NSTextField!
    @IBOutlet var fixButton: NSButton!
    static var xcodeAccess: XcodeAccess = XcodeAccessImpl()

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: NSNotification.Name(rawValue: "NSApplicationDidBecomeActiveNotification"), object: nil)
        updateView()
    }

    @objc func updateView() {
        handleStatus(XcodeAccessView.xcodeAccess.request())
    }

    private func handleStatus(_ status: XcodeAccessStatus) {
        let message: String
        var hideFixButton = true
        switch status {
        case .granted:
            message = "✔︎ Mock Generator has access to Xcode"
        case .denied:
            hideFixButton = false
            message = "⚠️ Mock Generator does not have permission to access Xcode.\nGo to System Preferences -> Security & Privacy -> Privacy -> Automation and make sure this app is allowed to control Xcode.\nThen restart the app."
        case .notRunning:
            message = "Open Xcode to check if Mock Generator has access to Xcode"
        case .unknown(let code):
            message = "⚠️ Mock Generator does not have permission to access Xcode for an unknown reason (\(code))"
        case .requiresConsent:
            message = "Requesting access to Xcode..."
        }
        messageField.stringValue = message
        fixButton.isHidden = hideFixButton
    }

    @IBAction func didTapFixButton(_ sender: Any) {
        let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Automation")!
        NSWorkspace.shared.open(url)
    }
}
