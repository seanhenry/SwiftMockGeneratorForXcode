import Foundation

class Preferences {
    
    private lazy var userDefaults = UserDefaults(suiteName: "group.codes.seanhenry.MockGenerator")!
    
    var projectPath: URL? {
        set {
            userDefaults.set(newValue, forKey: "project.path")
            userDefaults.synchronize()
        }
        get {
            return userDefaults.url(forKey: "project.path")
        }
    }
}
