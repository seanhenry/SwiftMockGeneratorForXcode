class FormatUtil {

    static var formatRequest: FormatRequest!
    private let tempFileWriter = TempFileWriterUtil()
    private var tempFile: String { return tempFileWriter.tempFile }

    func format(_ element: Element) -> Element {
        guard let file = element.file else { return element }
        tempFileWriter.write(file.text)
        if let formatted = format() {
            return SKElementFactory().build(from: formatted) ?? element
        }
        return element
    }

    private func format() -> String? {
        return try? FormatUtil.formatRequest.format(filePath: tempFile)
    }
}
