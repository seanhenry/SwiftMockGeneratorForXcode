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
    private let sdkPathKey = "sdk.path"

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
        if let index = history.firstIndex(of: path) {
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

    var sdkPath: String {
        set {
            userDefaults.set(newValue, forKey: sdkPathKey)
        }
        get {
            return userDefaults.string(forKey: sdkPathKey)
                ??  "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk"
        }
    }
}
