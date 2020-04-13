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
    private let extensionBookmarkKey = "bookmarks.extension"
    private let temporaryBookmarkKey = "bookmarks.temporary"
    private let sdkPathKey = "sdk.path" // This was once used
    private let moduleCachePathKey = "moduleCache.path" // This was once used
    private let platformKey = "platform" // This was once used

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

    func extensionBookmark(forURL url: URL) -> Data? {
        return extensionBookmarks[url.path]
    }

    func setExtensionBookmark(_ bookmark: Data, forURL url: URL) {
        var bookmarks = extensionBookmarks
        bookmarks[url.path] = bookmark
        userDefaults.set(bookmarks, forKey: extensionBookmarkKey)
        userDefaults.synchronize()
    }

    private var extensionBookmarks: [String: Data] {
        return userDefaults.dictionary(forKey: extensionBookmarkKey)?
            .compactMapValues { $0 as? Data } ?? [:]
    }

    func temporaryBookmark(forURL url: URL) -> Data? {
        return temporaryBookmarks[url.path]
    }

    func setTemporaryBookmark(_ bookmark: Data, forURL url: URL) {
        var bookmarks = temporaryBookmarks
        bookmarks[url.path] = bookmark
        userDefaults.set(bookmarks, forKey: temporaryBookmarkKey)
        userDefaults.synchronize()
    }

    private var temporaryBookmarks: [String: Data] {
        return userDefaults.dictionary(forKey: temporaryBookmarkKey)?
            .compactMapValues { $0 as? Data } ?? [:]
    }
}
