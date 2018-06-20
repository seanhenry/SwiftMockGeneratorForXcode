import SourceKittenFramework

public class SKCursorInfoRequest: CursorInfoRequest {

    let files: [String]
    private static let cores: Int = {
        return max(ProcessInfo.processInfo.processorCount, 4)
    }()
    private static let parallelOption: String = {
        return "-j\(cores)"
    }()

    public init(files: [String]) {
        self.files = files
    }

    public func getCursorInfo(filePath: String, offset: Int64) throws -> [String: Any] {
        let arguments = [SKCursorInfoRequest.parallelOption] + files + [filePath]
        return try Request.cursorInfo(file: filePath, offset: offset, arguments: arguments).send()
    }
}
