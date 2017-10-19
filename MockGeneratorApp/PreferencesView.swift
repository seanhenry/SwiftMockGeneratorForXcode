import AppKit

class PreferencesView: NSView {
    
    @IBOutlet var projectPathHistory: NSPopUpButton!
    private static let clearTitle = "Clear history"
    private static let browseTitle = "Browse..."
    private let preferences = Preferences()
    
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
            preferences.projectPath = panel.directoryURL
            refreshHistory()
        }
    }

    @IBAction func didTapClearHistoryButton(_ sender: Any?) {
        preferences.clearProjectPathHistory()
        refreshHistory()
    }

    private func startingDirectory() -> String {
        return projectPathHistory.selectedItem?.title ?? NSHomeDirectory()
    }

    private func refreshHistory() {
        let paths = preferences.projectPathHistory.map { $0.path }
        projectPathHistory.removeAllItems()
        if paths.isEmpty {
            projectPathHistory.addItem(withTitle: PreferencesView.browseTitle)
            return
        }
        projectPathHistory.addItems(withTitles: paths)
        projectPathHistory.menu?.addItem(.separator())
        projectPathHistory.addItem(withTitle: PreferencesView.clearTitle)
    }

    @objc private func didChangeSelection(_ sender: Any?) {
        guard let title = projectPathHistory.selectedItem?.title else { return }
        if title == PreferencesView.clearTitle {
            preferences.clearProjectPathHistory()
            preferences.projectPath = nil
        } else if title == PreferencesView.browseTitle {
            didTapProjectPathButton(nil)
        } else {
            preferences.projectPath = URL(fileURLWithPath: title)
        }
        refreshHistory()
    }
}
