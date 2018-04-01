import SourceKittenFramework

public class SKCursorInfoRequest: CursorInfoRequest {

    private let files: [String]

    public init(files: [String]) {
        self.files = files
    }

    public func getCursorInfo(filePath: String, offset: Int64) throws -> [String: Any] {
        let arguments = files + [filePath]
        return try Request.cursorInfo(file: filePath, offset: offset, arguments: arguments).send()
    }
}
