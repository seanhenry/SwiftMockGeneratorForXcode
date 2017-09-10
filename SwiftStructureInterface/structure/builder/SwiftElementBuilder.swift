import SourceKittenFramework

class SwiftElementBuilder {

    let fileText: String
    let data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    // TODO: make this build() and figure out whether prot extensions or generics is best
    func buildSwiftElement() -> SwiftElement {
        let offset = getOffset()
        let length = getLength()
        let text = getText(offset: offset, length: length)
        return SwiftElement(name: getName(), text: text, children: buildChildren(), offset: offset, length: length)
    }

    func getText(offset: Int64, length: Int64) -> String {
        let utf8 = fileText.utf8
        let lastTextIndex = Int64(utf8.count)
        if offset < 0 || length < 0 || lastTextIndex < offset + length {
            return ""
        }
        let start = utf8.index(utf8.startIndex, offsetBy: Int(offset))
        let end = utf8.index(start, offsetBy: Int(length))
        return String(utf8[start..<end])!
    }

    func buildChildren() -> [Element] {
        return getSubStructure()?.flatMap {
            StructureBuilder().build(data: $0, fileText: fileText)
        } ?? []
    }

    func getSubStructure() -> [[String: SourceKitRepresentable]]? {
        return data["key.substructure"] as? [[String: SourceKitRepresentable]]
    }

    func getName() -> String {
        let name = (data["key.name"] as? String)
        return name?.components(separatedBy: "(").first ?? ""
    }

    func getOffset() -> Int64 {
        return (data["key.offset"] as? Int64) ?? -1
    }

    func getLength() -> Int64 {
        return (data["key.length"] as? Int64) ?? -1
    }

    // TODO: move these into a bodyoffset/legnth place?

    func getDeclarationText() -> String {
        let offset = getOffset()
        let bodyOffset = getStatementEndOffset()
        return getText(offset: offset, length: bodyOffset - offset)
    }

    func getStatementEndOffset() -> Int64 {
        var statementEndOffset = getBodyOffset() - 1
        if statementEndOffset < 0 {
            statementEndOffset = getOffset() + getLength()
        }
        return statementEndOffset
    }

    func getBodyOffset() -> Int64 {
        return (data["key.bodyoffset"] as? Int64) ?? -1
    }

    func getBodyLength() -> Int64 {
        return (data["key.bodylength"] as? Int64) ?? -1
    }
}
