class TempFileWriterUtil {

    let tempFile = NSTemporaryDirectory() + "codes.seanhenry.mockgenerator/" + UUID().uuidString + ".swift"

    func write(_ string: String) {
        try? string.data(using: .utf8)!
            .write(to: URL(fileURLWithPath: tempFile))
    }

    func write(_ lines: [String]) {
        write(lines.joined())
    }
}
