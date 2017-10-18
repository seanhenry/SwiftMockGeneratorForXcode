import SourceKittenFramework

class FormatUtil {

    private let tempFileWriter = TempFileWriterUtil()
    private var tempFile: String { return tempFileWriter.tempFile }

    func format(_ element: Element) -> Element {
        guard let file = element.file else { return element }
        tempFileWriter.write(file.text)
        let formatted = SourceKittenFramework.File(path: tempFile)!.format(trimmingTrailingWhitespace: false, useTabs: false, indentWidth: 4)
        return SKElementFactory().build(from: formatted) ?? element
    }
}
