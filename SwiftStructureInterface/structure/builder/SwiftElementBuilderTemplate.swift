import SourceKittenFramework

protocol SwiftElementBuilderTemplate {
    var data: [String: SourceKitRepresentable] { get }
    var fileText: String { get }
    func build(text: String, offset: Int64, length: Int64) -> Element?
}

extension SwiftElementBuilderTemplate {

    func build() -> Element? {
        guard let offset = getOffset(),
            let length = getLength(),
            let text = getText(offset: offset, length: length) else {
            return nil
        }
        return build(text: text, offset: offset, length: length)
    }

    func getText(offset: Int64, length: Int64) -> String? {
        let utf8 = fileText.utf8
        let lastTextIndex = Int64(utf8.count)
        if offset < 0 || length < 0 || lastTextIndex < offset + length {
            return nil
        }
        let start = utf8.index(utf8.startIndex, offsetBy: Int(offset))
        let end = utf8.index(start, offsetBy: Int(length))
        return String(utf8[start..<end])
    }

    func buildChildren() -> [Element] {
        return getSubStructure()?.flatMap {
            SKElementFactory().build(data: $0, fileText: fileText)
        } ?? []
    }

    func getSubStructure() -> [[String: SourceKitRepresentable]]? {
        return data["key.substructure"] as? [[String: SourceKitRepresentable]]
    }

    func getOffset() -> Int64? {
        return data["key.offset"] as? Int64
    }

    func getLength() -> Int64? {
        return data["key.length"] as? Int64
    }

    func getDeclarationText() -> String? {
        guard let offset = getOffset() else { return nil }
        let bodyOffset = getStatementEndOffset()
        return getText(offset: offset, length: bodyOffset - offset)
    }

    func getStatementEndOffset() -> Int64 {
        guard let bodyOffset = data["key.bodyoffset"] as? Int64 else {
            return getEndOffset()
        }
        let openBraceCharacterCount: Int64 = 1
        return bodyOffset - openBraceCharacterCount
    }

    private func getEndOffset() -> Int64 {
        if let offset = getOffset(),
           let length = getLength() {
            return offset + length
        }
        return 0
    }
}
