import SourceKittenFramework

class SwiftMethodElementBuilder: NamedSwiftElementBuilderTemplate {

    let fileText: String
    let data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64, name: String) -> Element? {
        let returnType = getMethodReturnType()
        return SwiftMethodElement(name: name, text: text, children: buildChildren(), offset: offset, length: length, returnType: returnType)
    }

    private func getMethodReturnType() -> String? {
        let returnStatementText = getReturnStatementText()
        let returnMarker = "->"
        if let components = returnStatementText?.components(separatedBy: returnMarker),
           components.count >= 2 {
            return components[1..<components.count]
                .joined(separator: returnMarker)
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return nil
    }

    private func getReturnStatementText() -> String? {
        guard var text = getDeclarationText()?.utf8 else { return nil }
        var openBracketCount = 0
        var offset = text.startIndex
        repeat {
            guard let firstBracketOffset = firstBracketIndex(text: text) else { break }
            openBracketCount += isOpenBracket(bracket: text[firstBracketOffset]) ? 1 : -1
            offset = text.index(after: firstBracketOffset)
            text = text[offset..<text.endIndex]
        } while openBracketCount > 0
        return String(text[offset..<text.endIndex])!
    }

    private func isOpenBracket(bracket: UTF8.CodeUnit) -> Bool {
        return bracket == openBracketUTF8
    }

    private func firstBracketIndex(text: String.UTF8View) -> String.UTF8View.Index? {
        return text.index { $0 == openBracketUTF8 || $0 == closedBracketUTF8 }
    }

    private let closedBracketUTF8: UTF8.CodeUnit = {
        let closedBracket = ")".utf8
        return closedBracket[closedBracket.startIndex]
    }()

    private let openBracketUTF8: UTF8.CodeUnit = {
        let openBracket = "(".utf8
        return openBracket[openBracket.startIndex]
    }()
}
