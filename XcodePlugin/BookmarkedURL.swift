import Foundation
import MockGenerator

enum BookmarkedURL {

    static func bookmarkedURL(url: URL) throws -> URL {
        if let bookmarkedURL = securityScopedURL(url: url) {
            return bookmarkedURL
        } else if let bookmarkedURL = temporaryURL(url: url) {
            let newBookmark = try bookmarkedURL.bookmarkData(
                options: .withSecurityScope,
                includingResourceValuesForKeys: nil,
                relativeTo: nil
            )
            Preferences().setExtensionBookmark(newBookmark, forURL: url)
            return bookmarkedURL
        }
        throw error(
            "The directory '\(url.lastPathComponent)' could not be opened. Grant permission in the companion app."
        )
    }

    private static func securityScopedURL(url: URL) -> URL? {
        return bookmarkedURL(
            Preferences().extensionBookmark(forURL: url),
            options: [.withoutUI, .withSecurityScope]
        )
    }

    private static func temporaryURL(url: URL) -> URL? {
        return bookmarkedURL(Preferences().temporaryBookmark(forURL: url), options: .withoutUI)
    }

    private static func bookmarkedURL(_ bookmark: Data?, options: URL.BookmarkResolutionOptions) -> URL? {
        var isStale = false
        guard let bookmark = bookmark,
            let url = try? URL(
                resolvingBookmarkData: bookmark,
                options: options,
                relativeTo: nil,
                bookmarkDataIsStale: &isStale
            ), !isStale
        else {
            return nil
        }
        return url
    }

}
