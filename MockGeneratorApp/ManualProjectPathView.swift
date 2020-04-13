import AppKit

class ManualProjectPathView: NSStackView {

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
        panel.allowedFileTypes = ["none"]
        let startingDirectory = self.startingDirectory()
        panel.directoryURL = URL(fileURLWithPath: startingDirectory)
        if panel.runModal() == NSApplication.ModalResponse.OK {
            preferences.projectPath = panel.directoryURL
            refreshHistory()
            bookmark(panel.directoryURL)
        }
    }

    private func startingDirectory() -> String {
        return projectPathHistory.selectedItem?.title ?? NSHomeDirectory()
    }

    private func refreshHistory() {
        let paths = preferences.projectPathHistory.map { $0.path }
        projectPathHistory.removeAllItems()
        if paths.isEmpty {
            projectPathHistory.addItem(withTitle: ManualProjectPathView.browseTitle)
            return
        }
        projectPathHistory.addItems(withTitles: paths)
        projectPathHistory.menu?.addItem(.separator())
        projectPathHistory.addItem(withTitle: ManualProjectPathView.clearTitle)
    }

    @objc private func didChangeSelection(_ sender: Any?) {
        guard let title = projectPathHistory.selectedItem?.title else { return }
        if title == ManualProjectPathView.clearTitle {
            preferences.clearProjectPathHistory()
            preferences.projectPath = nil
        } else if title == ManualProjectPathView.browseTitle {
            didTapProjectPathButton(nil)
        } else {
            preferences.projectPath = URL(fileURLWithPath: title)
        }
        refreshHistory()
    }
}
