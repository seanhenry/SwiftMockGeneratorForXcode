import SourceKittenFramework

class ResolveUtil {

    static var files = [String]()

    private let tempFile = NSTemporaryDirectory() + UUID().uuidString + "_ResolveUtil.swift"

    func resolve(_ element: Element) -> Element? {
        guard let file = element.file else { return nil }
        writeContentsToTempDirectory(file.text)
        let data = Request.cursorInfo(file: tempFile, offset: element.offset, arguments: ResolveUtil.files + [tempFile]).send()
        if let path = data["key.filepath"] as? String,
           let offset = data["key.offset"] as? Int64,
           let file = SourceKittenFramework.File(path: path) {
            let structure = Structure(file: file)
            let resolvedFile = StructureBuilder(data: structure.dictionary, text: file.contents).build()
            return CaretUtil().findElementUnderCaret(in: resolvedFile, cursorOffset: offset)
        }
        return nil
    }

    // Workaround: there is an issue where SourceKit does not accept
    // key.sourcetext. This writes to a temp file to allow the use
    // of key.sourcefile.
    private func writeContentsToTempDirectory(_ contents: String) {
        do {
            try contents.data(using: .utf8)!
                .write(to: URL(fileURLWithPath: tempFile))
        } catch {
            print("Workaround \(type(of: self)).\(#function) failed: \(error)")
        }
    }
}
