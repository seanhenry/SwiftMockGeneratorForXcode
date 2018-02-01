class SwiftTypeBuilder: SwiftElementBuilderTemplate {

    let data: [String: Any]
    let fileText: String

    init(data: [String: Any], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64) -> Element? {
        guard let typeName = data["key.typename"] as? String else { return nil }
        let typeLength = Int64(typeName.utf16.count)
        let typeOffset = offset + length - typeLength
        return SwiftElement(text: getText(offset: typeOffset, length: typeLength) ?? "", children: [], offset: typeOffset, length: typeLength)
    }
}
