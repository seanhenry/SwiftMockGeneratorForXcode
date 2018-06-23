public class FormatUtil {

    public static var formatRequest: FormatRequest!
    private let tempFileWriter = TempFileWriterUtil()
    private var tempFile: String { return tempFileWriter.tempFile }
    private let useTabs: Bool
    private let spaces: Int

    public init(useTabs: Bool, spaces: Int) {
        self.useTabs = useTabs
        self.spaces = spaces
    }

    public func format(_ element: Element) -> Element {
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

    public func format(_ lines: [String], relativeTo element: Element) -> [String] {
        guard let file = element.file,
              let (_, column) = LocationConverter.convert(caretOffset: element.offset, in: file.text) else {
            return lines
        }
        let start = file.text.index(file.text.startIndex, offsetBy: Int(element.offset) - column)
        let end = file.text.index(start, offsetBy: column)
        let elementIndent = String(file.text[start..<end])
        let formatted = NaiveFormatter(useTabs: useTabs, spaces: spaces).format(lines: lines)
        let indent = useTabs ? "\t" : String(repeating: " ", count: spaces)
        return formatted.map { "\(elementIndent)\(indent)\($0)" }
    }
}
