class ResolveUtil {

    static var sameFileCursorInfoRequest: CursorInfoRequest!
    static var cursorInfoRequest: CursorInfoRequest!
    private let tempFileWriter = TempFileWriterUtil()
    private var tempFile: String { return tempFileWriter.tempFile }

    func resolve(_ element: Element) -> Element? {
        guard writeToFile(element) else { return nil }
        return getResolvedElement(from: resolveFromSameFile(element))
            ?? getResolvedElement(from: resolveFromAllFiles(element))
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

    private func getResolvedElement(from data: [String: Any]?) -> Element? {
        if let path = data?["key.filepath"] as? String,
           let offset = data?["key.offset"] as? Int64,
           let resolvedFile = SKElementFactory().build(fromPath: path) {
            return CaretUtil().findElementUnderCaret(in: resolvedFile, cursorOffset: offset)
        }
        return nil
    }

    func resolveTypealias(_ element: Element) -> String? {
        guard writeToFile(element) else { return nil }
        return getResolvedTypeName(resolveFromSameFile(element))
            ?? getResolvedTypeName(resolveFromAllFiles(element))
    }

    private func getResolvedTypeName(_ data: [String: Any]?) -> String? {
        guard let typeName = data?["key.typename"] as? String else { return nil }
        return removeTypeSuffix(typeName)
    }

    private func removeTypeSuffix(_ typeName: String) -> String {
        if typeName.hasSuffix(".Type") {
            let index = typeName.index(typeName.endIndex, offsetBy: -5)
            return String(typeName[..<index])
        }
        return typeName
    }
}
