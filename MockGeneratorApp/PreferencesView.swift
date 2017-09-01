import AppKit

class PreferencesView: NSView {
    
    @IBOutlet var jdkPathField: NSTextField!
    @IBOutlet var projectPathField: NSTextField!
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        jdkPathField.stringValue = Preferences().jdkPath?.path ?? ""
        projectPathField.stringValue = Preferences().projectPath?.path ?? ""
    }
    
    @IBAction func didTapJDKPathButton(_ sender: Any?) {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        var startingDirectory = jdkPathField.stringValue
        if startingDirectory == "" {
            startingDirectory = "/Library/Java/JavaVirtualMachines"
        }
        panel.directoryURL = URL(fileURLWithPath: startingDirectory)
        if panel.runModal() == NSModalResponseOK {
            Preferences().jdkPath = panel.directoryURL
            jdkPathField.stringValue = panel.directoryURL?.path ?? ""
        }
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
