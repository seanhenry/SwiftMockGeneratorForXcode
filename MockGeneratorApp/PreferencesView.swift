import AppKit

class PreferencesView: NSView {

    @IBOutlet private var manualContainer: NSView!
    @IBOutlet private var automaticContainer: NSView!
    @IBOutlet private var automaticPathCheckbox: NSButton!

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        updateContainers()
    }

    @IBAction private func didChangeAutomaticPathCheckbox(_ sender: NSButton) {
        updateContainers()
    }

    private func updateContainers() {
        let hideManualContainer = automaticPathCheckbox.state == .on
        manualContainer.isHidden = hideManualContainer
        automaticContainer.isHidden = !hideManualContainer
    }
}
