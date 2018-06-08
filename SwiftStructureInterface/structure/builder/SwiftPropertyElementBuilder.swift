class SwiftPropertyElementBuilder: NamedSwiftElementBuilderTemplate {

    let fileText: String
    let data: [String: Any]

    init(data: [String: Any], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64, name: String) -> Element? {
        let isWritable = getPropertyIsWritable()
        return VariableDeclarationImpl(name: name, text: text, children: buildChildren(), offset: offset, length: length, type: getType(), isWritable: isWritable)
    }

    private func getType() -> Type {
        return TypeImpl(text: getTypeName(), children: [], offset: -1, length: -1)
    }

    private func getTypeName() -> String {
        return data["key.typename"] as? String ?? ""
    }

    private func getPropertyIsWritable() -> Bool {
        return data["key.setter_accessibility"] != nil
    }
}
