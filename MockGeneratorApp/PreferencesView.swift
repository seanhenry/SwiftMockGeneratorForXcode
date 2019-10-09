import AppKit

class PreferencesView: NSView {

    @IBOutlet private var manualContainer: NSView!
    @IBOutlet private var automaticContainer: NSView!
    @IBOutlet private var automaticPathCheckbox: NSButton!
    @IBOutlet private var projectPathField: NSTextField!
    @IBOutlet private var platformPopUpButton: NSPopUpButton!

    private let preferences = Preferences()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(detectProjectPath), name: NSWindow.didBecomeMainNotification, object: nil)
    }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        updateView()
    }

    @IBAction private func didChangeAutomaticPathCheckbox(_ sender: NSButton) {
        updateAutomaticPathPreference()
        updateView()
        detectProjectPath()
    }

    private func updateAutomaticPathPreference() {
        preferences.automaticallyDetectProjectPath = automaticPathCheckbox.state == .on
    }

    private func updateView() {
        automaticPathCheckbox.state = preferences.automaticallyDetectProjectPath ? .on : .off
        updateContainers()
        updatePlatformPopUpButton()
    }

    private func updateContainers() {
        let hideManualContainer = preferences.automaticallyDetectProjectPath
        manualContainer.isHidden = hideManualContainer
        automaticContainer.isHidden = !hideManualContainer
    }

    @objc private func detectProjectPath() {
        if let project = XcodeProjectPathFinder().findOpenProjectPath() {
            projectPathField.stringValue = project.path
        } else {
            projectPathField.stringValue = "Cannot find a project. Make sure a project is open in Xcode."
        }
    }

    @IBAction private func comboBoxSelectionDidChange(_ sender: Any) {
        switch platformPopUpButton.selectedItem?.title {
        case "macOS": preferences.platform = "macosx"
        case "iOS": preferences.platform = "iphonesimulator"
        default: preferences.platform = nil
        }
        updatePlatformPopUpButton()
    }

    private func updatePlatformPopUpButton() {
        switch preferences.platform {
        case "macosx": platformPopUpButton.selectItem(withTitle: "macOS")
        case "iphonesimulator": platformPopUpButton.selectItem(withTitle: "iOS")
        default: platformPopUpButton.selectItem(at: -1)
        }
    }
}
