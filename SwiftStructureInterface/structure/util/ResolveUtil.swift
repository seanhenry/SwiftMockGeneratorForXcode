class ResolveUtil {

    static var sameFileCursorInfoRequest: CursorInfoRequest!
    static var cursorInfoRequest: CursorInfoRequest!
    private let tempFileWriter = TempFileWriterUtil()
    private var tempFile: String { return tempFileWriter.tempFile }

    func resolve(_ element: Element) -> Element? {
        guard writeToFile(element) else { return nil }
        return getResolvedElementInFile(from: resolveFromSameFile(element))
            ?? getResolvedElementInFile(from: resolveFromAllFiles(element))
    }

    private func writeToFile(_ element: Element) -> Bool {
        guard let file = element.file else { return false }
        tempFileWriter.write(file.text)
        return true
    }

    private func resolveFromSameFile(_ element: Element) -> [String: Any]? {
        return try? ResolveUtil.sameFileCursorInfoRequest.getCursorInfo(filePath: tempFile, offset: element.offset)
    }

    private func resolveFromAllFiles(_ element: Element) -> [String: Any]? {
        return try? ResolveUtil.cursorInfoRequest.getCursorInfo(filePath: tempFile, offset: element.offset)
    }

    private func getResolvedElementInFile(from data: [String: Any]?) -> Element? {
        if let path = data?["key.filepath"] as? String,
           let offset = data?["key.offset"] as? Int64,
           let resolvedFile = SKElementFactory().build(fromPath: path) {
            return CaretUtil().findElementUnderCaret(in: resolvedFile, cursorOffset: offset)
        }
        return nil
    }


    func resolveToElement(_ element: Element) -> Element? {
        guard writeToFile(element) else { return nil }
        return getResolvedElement(from: resolveFromSameFile(element))
            ?? getResolvedElement(from: resolveFromAllFiles(element))
    }

    private func getResolvedElement(from data: [String: Any]?) -> Element? {
        if let data = data,
           let path = data["key.filepath"] as? String,
           let resolvedFile = SKElementFactory().build(fromPath: path) {
            return SKElementFactory().build(data: data, fileText: resolvedFile.text)
        }
        return nil
    }
}
