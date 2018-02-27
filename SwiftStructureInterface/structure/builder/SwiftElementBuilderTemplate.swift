protocol SwiftElementBuilderTemplate {
    var data: [String: Any] { get }
    var fileText: String { get }
    func build(text: String, offset: Int64, length: Int64) -> Element?
}

func getSubstring(from text: String, offset: Int64, length: Int64) -> String? {
    let utf8 = text.utf8
    let lastTextIndex = Int64(utf8.count)
    if offset < 0 || length < 0 || lastTextIndex < offset + length {
        return nil
    }
    let start = utf8.index(utf8.startIndex, offsetBy: Int(offset))
    let end = utf8.index(start, offsetBy: Int(length))
    return String(utf8[start..<end])
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
        return getSubstring(from: fileText, offset: offset, length: length)
    }

    func buildChildren() -> [Element] {
        return getSubStructure()?.flatMap {
            SKElementFactory().build(data: $0, fileText: fileText)
        } ?? []
    }

    func getSubStructure() -> [[String: Any]]? {
        return data["key.substructure"] as? [[String: Any]]
    }

    func getOffset() -> Int64? {
        return getLargeInt(data["key.offset"])
    }

    func getLength() -> Int64? {
        return getLargeInt(data["key.length"])
    }

    private func getLargeInt(_ any: Any?) -> Int64? {
        if let bigNumber = any as? Int64 {
            return bigNumber
        } else if let littleNumber = any as? Int {
            return Int64(littleNumber)
        }
        return nil
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
