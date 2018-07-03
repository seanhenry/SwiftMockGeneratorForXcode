class SKResolver: ResolverDecorator {

    private let cursorInfoRequest: CursorInfoRequest
    private let fileWriter: TempFileWriterUtil
    private var tempFile: String { return fileWriter.tempFile }

    init(_ decorator: Resolver?, cursorInfoRequest: CursorInfoRequest, fileWriter: TempFileWriterUtil) {
        self.cursorInfoRequest = cursorInfoRequest
        self.fileWriter = fileWriter
        super.init(decorator)
    }

    override func resolve(_ element: Element) -> Element? {
        return getResolvedElementInFile(from: doResolve(element))
            ?? super.resolve(element)
    }

    private func doResolve(_ element: Element) -> [String: Any]? {
//        return try? cursorInfoRequest.getCursorInfo(filePath: tempFile, offset: element.offset)
        fatalError()
    }

    private func getResolvedElementInFile(from data: [String: Any]?) -> Element? {
        if let path = data?["key.filepath"] as? String,
           let offset = data?["key.offset"] as? Int,
           let resolvedFile = try? ElementParser.parseFile(at: path) {
            return CaretUtil().findElementUnderCaret(in: resolvedFile, cursorOffset: offset, type: Declaration.self)
        }
        return nil
    }
}
