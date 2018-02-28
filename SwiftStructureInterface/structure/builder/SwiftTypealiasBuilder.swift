class SwiftTypealiasBuilder: SwiftElementBuilderTemplate {

    let fileText: String
    let data: [String: Any]

    init(data: [String: Any], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64) -> Element? {
        guard let typeName = data["key.typename"] as? String else { return nil }
        return SwiftTypealias(text: text, children: [], offset: offset, length: length, typeName: removeTypeSuffix(typeName))
    }

    private func removeTypeSuffix(_ typeName: String) -> String {
        if typeName.hasSuffix(".Type") {
            let index = typeName.index(typeName.endIndex, offsetBy: -5)
            return String(typeName[..<index])
        }
        return typeName
    }
}
