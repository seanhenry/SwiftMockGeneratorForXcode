import Foundation

class Preferences {

    private let userDefaults: UserDefaults
    private let projectPathKey = "project.path"

    init(userDefaults: UserDefaults = UserDefaults(suiteName: "group.codes.seanhenry.MockGenerator")!) {
        self.userDefaults = userDefaults
    }

    var projectPath: URL? {
        set {
            userDefaults.set(newValue, forKey: projectPathKey)
            userDefaults.synchronize()
        }
        get {
            return userDefaults.url(forKey: projectPathKey)
        }
    }
}
