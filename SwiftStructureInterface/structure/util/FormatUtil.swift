import SourceKittenFramework

// TODO: Look into source.request.editor.replacetext if this is a performance problem
class FormatUtil {

    private let tempFileWriter = TempFileWriterUtil()
    private var tempFile: String { return tempFileWriter.tempFile }

    func format(_ element: Element) -> Element {
        guard let file = element.file else { return element }
        let (startLine, _) = LocationConverter.convert(caretOffset: element.offset, in: file.text)!
        let (endLine, _) = LocationConverter.convert(caretOffset: element.offset + element.length, in: file.text)!
        var formattedArray = file.text.components(separatedBy: .newlines)
        tempFileWriter.write(file.text)
        do {
            for i in (startLine+1)...(endLine+1) {
                try openFileInEditor()
                let formatted = try formatLine(i)
                if let newText = formatted["key.sourcetext"] as? String {
                    formattedArray[i-1] = newText
                    tempFileWriter.write(stitch(formattedArray))
                }
            }
            let formattedString = stitch(formattedArray)
            return SKElementFactory().build(from: formattedString)
        } catch {
            print("Error: \(error)\nFailed to format: \(element.text)")
        }
        return element
    }

    private func openFileInEditor() throws {
        _ = try Request.editorOpen(file: SourceKittenFramework.File(path: tempFile)!).failableSend()
    }

    private func formatLine(_ line: Int) throws -> [String: SourceKitRepresentable] {
        return try Request.format(file: tempFile, line: Int64(line), useTabs: false, indentWidth: 4).failableSend()
    }

    private func stitch(_ array: [String]) -> String {
        return array.joined(separator: "\n")
    }
}
