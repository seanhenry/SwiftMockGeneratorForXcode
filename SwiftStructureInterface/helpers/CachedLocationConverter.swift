class CachedLocationConverter {

    private static let newLineCharacterCount = 1
    private let text: String
    private var lineOffsets: [Int]
    private var lineScalarStartIndexes: [String.Index]
    private let lines: [String]

    init(_ text: String) {
        self.text = text
        lines = CachedLocationConverter.appendNewlines(to: text.components(separatedBy: .newlines))
        lineOffsets = CachedLocationConverter.createUTF8LineStartOffsets(text, lines)
        lineScalarStartIndexes = CachedLocationConverter.createScalarLineStartIndexes(text, lines)
    }

    private static func appendNewlines(to lines: [String]) -> [String] {
        return lines.enumerated().map { i, line in
            let isLastLine = lines.count - 1 == i
            if isLastLine {
                return line
            }
            return line + "\n"
        }
    }

    private static func createUTF8LineStartOffsets(_ text: String, _ lines: [String]) -> [Int] {
        let lineLengths = lines.map { $0.utf8.count }
        var lineOffsets = [Int]()
        var offset = 0
        for length in lineLengths {
            lineOffsets.append(offset)
            offset += length
        }
        return lineOffsets
    }

    private static func createScalarLineStartIndexes(_ text: String, _ lines: [String]) -> [String.Index] {
        var lineScalarStartIndexes = [String.Index]()
        var index = text.unicodeScalars.startIndex
        let scalarLengths = lines.map { $0.unicodeScalars.count }
        for length in scalarLengths {
            lineScalarStartIndexes.append(index)
            index = text.unicodeScalars.index(index, offsetBy: length)
        }
        return lineScalarStartIndexes
    }

    func convertToIndex(line: Int, column: Int) -> String.Index? {
        let zeroBasedLine = line - 1
        guard areLineAndColumnValid(zeroBasedLine, column, in: lines) else { return nil }
        return findIndex(atLine: zeroBasedLine, atColumn: column, in: lines)
    }

    func convertToOffset(line: Int, column: Int) -> Int64? {
        let zeroBasedLine = line - 1
        guard areLineAndColumnValid(zeroBasedLine, column, in: lines) else { return nil }
        return findOffset(atLine: zeroBasedLine, atColumn: column, in: lines)
    }

    private func areLineAndColumnValid(_ line: Int, _ column: Int, in lines: [String]) -> Bool {
        return 0 <= line && line < lines.count && 0 <= column
    }

    private func findOffset(atLine line: Int, atColumn column: Int, in lines: [String]) -> Int64? {
        let offset = getOffset(atLine: line)
        let scalars = lines[line].unicodeScalars
        let scalarIndex = scalars.index(scalars.startIndex, offsetBy: column, limitedBy: scalars.endIndex)
        let utf8 = lines[line].utf8
        if let utf8Index = scalarIndex?.samePosition(in: utf8) {
            return offset + Int64(utf8.distance(from: utf8.startIndex, to: utf8Index))
        }
        return nil
    }

    private func findIndex(atLine line: Int, atColumn column: Int, in lines: [String]) -> String.Index? {
        let index = getIndex(atLine: line)
        if let columnIndex = text.unicodeScalars.index(index, offsetBy: column, limitedBy: text.unicodeScalars.endIndex) {
            return columnIndex.samePosition(in: text.utf8)
        }
        return nil
    }

    private func getOffset(atLine line: Int) -> Int64 {
        return Int64(lineOffsets[line])
    }

    private func getIndex(atLine line: Int) -> String.Index {
        return lineScalarStartIndexes[line]
    }
}
