import Foundation

public class TempFileWriterUtil {

    private static let tempDir = NSTemporaryDirectory() + "codes.seanhenry.mockgenerator/"
    var tempFile = ""

    public init() {}

    func write(_ string: String) {
        tempFile = TempFileWriterUtil.tempDir + UUID().uuidString + ".swift"
        try? FileManager.default.createDirectory(at: URL(fileURLWithPath: TempFileWriterUtil.tempDir), withIntermediateDirectories: true, attributes: nil)
        try? string.data(using: .utf8)!
            .write(to: URL(fileURLWithPath: tempFile))
    }

    func write(_ lines: [String]) {
        write(lines.joined())
    }
}
