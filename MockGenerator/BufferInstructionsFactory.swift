import SwiftStructureInterface

class BufferInstructionsFactory {

    func create(mockClass: TypeDeclaration, lines: [String]) -> BufferInstructions? {
        guard let fileText = mockClass.file?.text,
              let startLineColumn = LocationConverter.convert(caretOffset: mockClass.bodyOffset, in: fileText),
              let endLineColumn = LocationConverter.convert(caretOffset: mockClass.bodyOffset + mockClass.bodyLength, in: fileText) else {
            return nil
        }
        return getDeletionInstructions(startLineColumn: startLineColumn, endLineColumn: endLineColumn, lines: lines, fileText: fileText)
    }

    private func getDeletionInstructions(startLineColumn: (line: Int, column: Int), endLineColumn: (line: Int, column: Int), lines: [String], fileText: String) -> BufferInstructions {
        var lines = lines
        var deleteIndex = startLineColumn.line
        var deleteLength = 0
        if startLineColumn.line != endLineColumn.line {
            deleteLength = endLineColumn.line - startLineColumn.line - 1
        } else {
            let (start, end) = chopClassDeclaration(startLineColumn: startLineColumn, endLineColumn: endLineColumn, fileText: fileText)
            lines.insert(start, at: 0)
            lines.append(end)
            deleteIndex -= 1
            deleteLength += 1
        }
        return BufferInstructions(deleteIndex: deleteIndex, deleteLength: deleteLength, insertIndex: deleteIndex, linesToInsert: lines)
    }

    private func chopClassDeclaration(startLineColumn: (line: Int, column: Int), endLineColumn: (line: Int, column: Int), fileText: String) -> (String, String) {
        let lineText = getLineText(at: startLineColumn.line, from: fileText)
        let classStartIndex = lineText.startIndex
        let classStartEndIndex = lineText.index(classStartIndex, offsetBy: startLineColumn.column)
        let classStart = String(lineText[classStartIndex..<classStartEndIndex]) + "\n"

        let classEndStartIndex = lineText.index(lineText.startIndex, offsetBy: endLineColumn.column)
        let classEnd = String(lineText[classEndStartIndex...])
        return (classStart, classEnd)
    }

    private func getLineText(at line: Int, from fileText: String) -> String {
        let startOffset = LocationConverter.convert(line: line, column: 0, in: fileText)!
        let startIndex = fileText.index(fileText.startIndex, offsetBy: Int(startOffset))
        let startOfLine = fileText[startIndex...]
        if let endIndex = startOfLine.index(of: "\n") {
            return String(startOfLine[..<endIndex])
        }
        return String(startOfLine)
    }
}
