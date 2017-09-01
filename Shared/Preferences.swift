import Foundation

class Preferences {
    
    private lazy var userDefaults = UserDefaults(suiteName: "group.codes.seanhenry.MockGenerator")!
    private let projectPathKey = "project.path"
    private let jdkPathKey = "jdk.path"

    var projectPath: URL? {
        set {
            userDefaults.set(newValue, forKey: projectPathKey)
            userDefaults.synchronize()
        }
        get {
            return userDefaults.url(forKey: projectPathKey)
        }
    }

    var jdkPath: URL? {
        set {
            userDefaults.set(newValue, forKey: jdkPathKey)
            userDefaults.synchronize()
        }
        get {
            return userDefaults.url(forKey: jdkPathKey)
        }
    }
}
