import SourceKittenFramework

class SwiftPropertyElementBuilder: NamedSwiftElementBuilderTemplate {

    let fileText: String
    let data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64, name: String) -> Element? {
        let isWritable = getPropertyIsWritable()
        let attributeString = getAttributeString()
        return SwiftPropertyElement(name: name, text: text, children: buildChildren(), offset: offset, length: length, type: getTypeName(), isWritable: isWritable, attribute: attributeString)
    }

    private func getTypeName() -> String {
        return data["key.typename"] as? String ?? ""
    }

    private func getPropertyIsWritable() -> Bool {
        return data["key.setter_accessibility"] != nil
    }

    private func getAttributeString() -> String? {
        let attributes = data["key.attributes"] as? [[String: SourceKitRepresentable]]
        let attribute = attributes?.first?["key.attribute"] as? String
        var attributeString: String?
        if attribute == "source.decl.attribute.weak" {
            attributeString = "weak"
        }
        return attributeString
    }
}
