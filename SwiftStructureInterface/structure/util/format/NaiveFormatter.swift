class NaiveFormatter {

    private let braces = CharacterSet(charactersIn: "{}")
    private let useTabs: Bool
    private let spaces: Int
    private var bracesLevel = 0

    init(useTabs: Bool, spaces: Int) {
        self.useTabs = useTabs
        self.spaces = spaces
    }

    func format(lines: [String]) -> [String] {
        bracesLevel = 0
        return lines.map(trim)
                .map(indent)
    }

    private func trim(_ string: String) -> String {
        return string.trimmingCharacters(in: .whitespaces)
    }
    
    private func indent(_ string: String) -> String {
        defer { bracesLevel += countBraces(in: string, maxOffset: string.count) }
        return prependWhitespace(to: string, bracesLevel: bracesLevel)
    }

    private func countBraces(in string: String, maxOffset: Int) -> Int {
        var bracesLevel = 0
        for char in string.unicodeScalars where braces.contains(char) {
            bracesLevel += getBraceValue(char)
        }
        return bracesLevel
    }

    private func getBraceValue(_ char: UnicodeScalar) -> Int {
        return char == "{" ? 1 : -1
    }

    private func prependWhitespace(to string: String, bracesLevel: Int) -> String {
        var bracesLevel = bracesLevel
        if string.hasPrefix("}") {
            bracesLevel -= 1
        }
        bracesLevel = max(0, bracesLevel)
        let whitespace = String(repeating: getIndent(), count: bracesLevel)
        return "\(whitespace)\(string)"
    }

    private func getIndent() -> String {
        return useTabs ? "\t" : String(repeating: " ", count: spaces)
    }
}
