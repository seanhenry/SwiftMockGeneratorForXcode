import AppKit

class PreferencesView: NSView {
    
    @IBOutlet var projectPathHistory: NSPopUpButton!
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        refreshHistory()
        projectPathHistory.target = self
        projectPathHistory.action = #selector(didChangeSelection(_:))
    }
    
    @IBAction func didTapProjectPathButton(_ sender: Any?) {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        let startingDirectory = self.startingDirectory()
        panel.directoryURL = URL(fileURLWithPath: startingDirectory)
        if panel.runModal() == NSApplication.ModalResponse.OK {
            Preferences().projectPath = panel.directoryURL
            refreshHistory()
        }
    }

    private func startingDirectory() -> String {
        return projectPathHistory.selectedItem?.title ?? NSHomeDirectory()
    }

    private func refreshHistory() {
        let paths = Preferences().projectPathHistory.map { $0.path }
        projectPathHistory.removeAllItems()
        projectPathHistory.addItems(withTitles: paths)
    }

    @objc private func didChangeSelection(_ sender: Any?) {
        guard let title = projectPathHistory.selectedItem?.title else { return }
        Preferences().projectPath = URL(fileURLWithPath: title)
        refreshHistory()
    }
}
