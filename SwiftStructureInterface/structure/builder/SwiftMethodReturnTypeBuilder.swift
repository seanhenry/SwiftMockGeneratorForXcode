class SwiftMethodReturnTypeBuilder {

    let endOfParametersOffset: Int64
    let methodDeclarationOffset: Int64
    private var returnText: String!

    init(methodDeclarationText: String, endOfParametersOffset: Int64, methodDeclarationOffset: Int64 = 0) {
        self.endOfParametersOffset = endOfParametersOffset
        self.methodDeclarationOffset = methodDeclarationOffset
        self.returnText = getSubstring(fromUTF8Offset: Int(endOfParametersOffset - methodDeclarationOffset), from: methodDeclarationText)
    }

    func build() -> Element? {
        guard let range = findRangeOfReturnType() else { return nil }
        let (utf8Range, offset, length) = convertReturnTypeRange(range: range)
        return SwiftElement(
            text: String(returnText[utf8Range]),
            children: [],
            offset: endOfParametersOffset + Int64(offset),
            length: Int64(length - offset)
        )
    }

    private func findRangeOfReturnType() -> Range<Int>? {
        if let returnMarkerRange = returnText.range(of: "->") {
            let returnMarkerUpperBound = returnMarkerRange.upperBound.encodedOffset
            return findType(after: returnMarkerUpperBound)
        }
        return nil
    }

    private func findType(after offset: Int) -> Range<Int>? {
        if let first = findFirstTypeOffset(after: offset),
           let last = findLastTypeOffset(after: offset) {
            return first..<last
        }
        return nil
    }

    private func findFirstTypeOffset(after offset: Int) -> Int? {
        let substring = getSubstring(from: offset, from: returnText)
        if let firstOffset = firstNonWhitespaceIndex(in: String(substring)) {
            return offset + firstOffset
        }
        return nil
    }

    private func findLastTypeOffset(after offset: Int) -> Int? {
        let substring = getSubstring(from: offset, from: returnText)
            .reversed()
        if let firstOffset = firstNonWhitespaceIndex(in: String(substring)) {
            return returnText.count - firstOffset
        }
        return nil
    }

    private func firstNonWhitespaceIndex(in string: String) -> Int? {
        return string.index { c in
            return String(c).rangeOfCharacter(from: .whitespacesAndNewlines) == nil
        }?.encodedOffset
    }

    private func getSubstring(fromUTF8Offset offset: Int, from string: String) -> String {
        let index = string.utf8.index(string.utf8.startIndex, offsetBy: offset)
        return String(string[index...])
    }

    private func getSubstring(from offset: Int, from string: String) -> String {
        let index = string.index(string.startIndex, offsetBy: offset)
        return String(string[index...])
    }

    private func convertReturnTypeRange(range: Range<Int>) -> (Range<String.Index>, Int, Int) {
        let utf8Range = getUTF8IndexRange(range, from: returnText)
        let offset = getUTF8Offset(utf8Range.lowerBound)
        let length = getUTF8Offset(utf8Range.upperBound)
        return (utf8Range, offset, length)
    }

    private func getUTF8IndexRange(_ range: Range<Int>, from string: String) -> Range<String.Index> {
        return getUTF8Index(range.lowerBound, from: string)..<getUTF8Index(range.upperBound, from: string)
    }

    private func getUTF8Index(_ offset: Int, from string: String) -> String.Index {
        let index = string.index(string.startIndex, offsetBy: offset)
        return index.samePosition(in: string.utf8)!
    }

    private func getUTF8Offset(_ offset: String.Index) -> Int {
        return returnText.utf8.distance(from: returnText.utf8.startIndex, to: offset)
    }
}
