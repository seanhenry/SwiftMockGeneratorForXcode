public class FormatUtil {

    private let useTabs: Bool
    private let spaces: Int

    public init(useTabs: Bool, spaces: Int) {
        self.useTabs = useTabs
        self.spaces = spaces
    }

    public func format(_ lines: [String], relativeTo element: Element) -> [String] {
        let elementIndent = FindElementIndent().find(element)
        let formatted = NaiveFormatter(useTabs: useTabs, spaces: spaces).format(lines: lines)
        let indent = useTabs ? "\t" : String(repeating: " ", count: spaces)
        return formatted.map { "\(elementIndent)\(indent)\($0)" }
    }
}
