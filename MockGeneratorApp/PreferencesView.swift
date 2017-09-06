import AppKit

class PreferencesView: NSView {
    
    @IBOutlet var projectPathField: NSTextField!
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        projectPathField.stringValue = Preferences().projectPath?.path ?? ""
    }
    
    @IBAction func didTapProjectPathButton(_ sender: Any?) {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        var startingDirectory = projectPathField.stringValue
        if startingDirectory == "" {
            startingDirectory = NSHomeDirectory()
        }
        panel.directoryURL = URL(fileURLWithPath: startingDirectory)
        if panel.runModal() == NSModalResponseOK {
            Preferences().projectPath = panel.directoryURL
            projectPathField.stringValue = panel.directoryURL?.path ?? ""
        }
    }
}
