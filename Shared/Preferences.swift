import Foundation

class Preferences {

    /*
     Possible locations:
     ~/Library/Preferences (many plists found here)
     ~/Library/Containers/codes..../Data/Library/Preferences
     ~/Library/Group Containers
 */

    private let userDefaults: UserDefaults
    private let projectPathKey = "project.path"
    private let projectPathHistoryKey = "project.path.history"
    private let automaticallyDetectProjectPathKey = "project.path.autoDetect"

    init(userDefaults: UserDefaults = UserDefaults(suiteName: "group.codes.seanhenry.MockGenerator")!) {
        self.userDefaults = userDefaults
    }

    var projectPath: URL? {
        set {
            userDefaults.set(newValue, forKey: projectPathKey)
            appendToProjectPathHistory(path: newValue)
            userDefaults.synchronize()
        }
        get {
            return userDefaults.url(forKey: projectPathKey)
        }
    }

    var projectPathHistory: [URL] {
        return userDefaults.stringArray(forKey: projectPathHistoryKey)?
            .compactMap { URL(string: $0) }
            ?? []
    }

    func clearProjectPathHistory() {
        userDefaults.removeObject(forKey: projectPathHistoryKey)
        userDefaults.synchronize()
    }

    private func appendToProjectPathHistory(path: URL?) {
        guard let path = path else { return }
        var history = projectPathHistory
        if let index = history.index(of: path) {
            history.remove(at: index)
        }
        history.insert(path, at: 0)
        userDefaults.set(history.map { $0.absoluteString }, forKey: projectPathHistoryKey)
    }

    var automaticallyDetectProjectPath: Bool {
        set {
            userDefaults.set(newValue, forKey: automaticallyDetectProjectPathKey)
            userDefaults.synchronize()
        }
        get {
            return userDefaults.object(forKey: automaticallyDetectProjectPathKey) as? Bool ?? true
        }
    }
}
