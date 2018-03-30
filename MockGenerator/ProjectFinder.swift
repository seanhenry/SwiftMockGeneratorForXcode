import Foundation

class ProjectFinder {

    private let projectFinder: XcodeProjectPathFinder
    private let preferences: Preferences

    init(projectFinder: XcodeProjectPathFinder, preferences: Preferences) {
        self.projectFinder = projectFinder
        self.preferences = preferences
    }

    func getProjectPath() throws -> URL {
        if preferences.automaticallyDetectProjectPath {
            return try findProjectPath()
        } else {
            return try getManualProjectPath()
        }
    }

    private func findProjectPath() throws -> URL {
        if let path = projectFinder.findOpenProjectPath() {
            return path
        } else {
            throw error("Could not detect your project. Enter one in the companion app.")
        }
    }

    private func getManualProjectPath() throws -> URL {
        if let path = preferences.projectPath {
            return path
        } else {
            throw error("Set the project path in the Mock Generator companion app.")
        }
    }

    private func error(_ message: String) -> Error {
        return NSError(domain: "MockGenerator.ProjectFinder", code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
