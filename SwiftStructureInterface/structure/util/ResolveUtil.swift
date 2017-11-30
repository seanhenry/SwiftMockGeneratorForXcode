class ResolveUtil {

    static var cursorInfoRequest: CursorInfoRequest!
    private let tempFileWriter = TempFileWriterUtil()
    private var tempFile: String { return tempFileWriter.tempFile }

    func resolve(_ element: Element) -> Element? {
        guard let file = element.file else { return nil }
        tempFileWriter.write(file.text)
        let data = try? ResolveUtil.cursorInfoRequest.getCursorInfo(filePath: tempFile, offset: element.offset)
        if let path = data?["key.filepath"] as? String,
           let offset = data?["key.offset"] as? Int64,
           let resolvedFile = SKElementFactory().build(fromPath: path) {
            return CaretUtil().findElementUnderCaret(in: resolvedFile, cursorOffset: offset)
        }
        return nil
    }
}
