import SourceKittenFramework

class SwiftPropertyElementBuilder: SwiftElementBuilder {

    func build() -> Element {
        let offset = getOffset()
        let length = getLength()
        let text = getText(offset: offset, length: length)
        let isWritable = getPropertyIsWritable()
        let attributeString = getAttributeString()
        return SwiftPropertyElement(name: getName(), text: text, children: buildChildren(), offset: offset, length: length, type: getTypeName(), isWritable: isWritable, attribute: attributeString)
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
