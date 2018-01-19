import SourceKittenFramework

class SKCursorInfoRequest: CursorInfoRequest {

    private let files: [String]

    init(files: [String]) {
        self.files = files
    }

    func getCursorInfo(filePath: String, offset: Int64) throws -> [String: Any] {
        let arguments = files + [filePath]
        return Request.cursorInfo(file: filePath, offset: offset, arguments: arguments).send()
    }
}
