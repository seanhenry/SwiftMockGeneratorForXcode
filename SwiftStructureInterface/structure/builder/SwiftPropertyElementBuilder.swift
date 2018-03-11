class SwiftPropertyElementBuilder: NamedSwiftElementBuilderTemplate {

    let fileText: String
    let data: [String: Any]

    init(data: [String: Any], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64, name: String) -> Element? {
        let isWritable = getPropertyIsWritable()
        let attributeString = getAttributeString(offset: offset)
        return SwiftVariableDeclaration(name: name, text: text, children: buildChildren(), offset: offset, length: length, type: getTypeName(), isWritable: isWritable, attribute: attributeString)
    }

    private func getTypeName() -> String {
        return data["key.typename"] as? String ?? ""
    }

    private func getPropertyIsWritable() -> Bool {
        return data["key.setter_accessibility"] != nil
    }

    private func getAttributeString(offset: Int64) -> String? {
        let attributes = data["key.attributes"] as? [[String: Any]]
        let attribute = attributes?.first?["key.attribute"] as? String
        if attribute == "source.decl.attribute.weak" {
            let endIndex = fileText.index(fileText.startIndex, offsetBy: Int(offset))
            let pretext = fileText[..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines)
            if pretext.hasSuffix("weak") {
                return "weak"
            } else if pretext.hasSuffix("unowned") {
                return "unowned"
            } else if pretext.hasSuffix("unowned(safe)") {
                return "unowned(safe)"
            } else if pretext.hasSuffix("unowned(unsafe)") {
                return "unowned(unsafe)"
            }
        }
        return nil
    }
}
