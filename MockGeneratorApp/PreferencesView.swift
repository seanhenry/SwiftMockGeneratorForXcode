import AppKit

class PreferencesView: NSView {

    @IBOutlet private var manualContainer: NSView!
    @IBOutlet private var automaticContainer: NSView!
    @IBOutlet private var automaticPathCheckbox: NSButton!
    private let preferences = Preferences()

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        updateView()
    }

    @IBAction private func didChangeAutomaticPathCheckbox(_ sender: NSButton) {
        updateAutomaticPathPreference()
        updateView()
    }

    private func updateAutomaticPathPreference() {
        preferences.automaticallyDetectProjectPath = automaticPathCheckbox.state == .on
    }

    private func updateView() {
        automaticPathCheckbox.state = preferences.automaticallyDetectProjectPath ? .on : .off
        updateContainers()
    }

    private func updateContainers() {
        let hideManualContainer = preferences.automaticallyDetectProjectPath
        manualContainer.isHidden = hideManualContainer
        automaticContainer.isHidden = !hideManualContainer
    }
}
