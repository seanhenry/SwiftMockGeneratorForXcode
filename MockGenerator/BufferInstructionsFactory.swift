import AST
import Algorithms

class BufferInstructionsFactory {

    func create(mockClass: TypeDeclaration, lines: [String]) -> BufferInstructions? {
        guard let fileText = mockClass.file?.text else {
            return nil
        }
        let bodyStart = getFirstElementLineColumn(mockClass.codeBlock)
        let bodyEnd = getLastElementLineColumn(mockClass.codeBlock)
        return getDeletionInstructions(startLineColumn: bodyStart, endLineColumn: bodyEnd, lines: lines, fileText: fileText)
    }

    private func getFirstElementLineColumn(_ codeBlock: CodeBlock) -> (line: Int, column: Int) {
        let lineColumn = FindElementLocation().findLineColumn(codeBlock)
        return (lineColumn.line, column: lineColumn.column+1)
    }

    private func getLastElementLineColumn(_ codeBlock: CodeBlock) -> (line: Int, column: Int) {
        let lastChild = codeBlock.children.last!
        let lineColumn = FindElementLocation().findLineColumn(lastChild)
        if codeBlock.children.last?.text == "}" {
            return lineColumn
        }
        return (lineColumn.line, column: lineColumn.column + lastChild.text.count)
    }

    private func getDeletionInstructions(startLineColumn: (line: Int, column: Int), endLineColumn: (line: Int, column: Int), lines: [String], fileText: String) -> BufferInstructions {
        var lines = lines
        var deleteIndex = startLineColumn.line + 1
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
        let startOffset = LocationConverter(from: .utf32, to: .utf32)
            .convert(line: line, column: 0, in: fileText)!
        let startIndex = fileText.index(fileText.startIndex, offsetBy: Int(startOffset))
        let startOfLine = fileText[startIndex...]
        if let endIndex = startOfLine.firstIndex(of: "\n") {
            return String(startOfLine[..<endIndex])
        }
        return String(startOfLine)
    }
}
