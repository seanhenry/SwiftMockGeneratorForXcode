import Foundation

class ProjectFinder {

    private let projectFinder: XcodeProjectPathFinder
    private let preferences: Preferences

    init(projectFinder: XcodeProjectPathFinder, preferences: Preferences) {
        self.projectFinder = projectFinder
        self.preferences = preferences
    }

    func getProjectPath() -> (path: URL?, error: Error?) {
        if preferences.automaticallyDetectProjectPath {
            return findProjectPath()
        } else {
            return getManualProjectPath()
        }
    }

    private func findProjectPath() -> (URL?, Error?) {
        if let path = projectFinder.findOpenProjectPath() {
            return (path, nil)
        } else {
            return (nil, error("Could not detect your project. Enter one in the companion app."))
        }
    }

    private func getManualProjectPath() -> (URL?, Error?) {
        if let path = preferences.projectPath {
            return (path, nil)
        } else {
            return (nil, error("Set the project path in the Mock Generator companion app."))
        }
    }

    private func error(_ message: String) -> Error {
        return NSError(domain: "MockGenerator.ProjectFinder", code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
