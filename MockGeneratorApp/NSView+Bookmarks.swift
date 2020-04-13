import AppKit

extension NSView {

    func bookmark(_ url: URL?) {
        guard let url = url else { return }
        do {
            let bookmark = try url.bookmarkData(
                options: [],
                includingResourceValuesForKeys: nil,
                relativeTo: nil
            )
            Preferences().setTemporaryBookmark(bookmark, forURL: url)
        } catch {
            NSAlert(error: error).runModal()
        }
    }
}
