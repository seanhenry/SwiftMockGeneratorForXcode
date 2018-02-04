class SwiftTypeBuilder: SwiftElementBuilderTemplate {

    let data: [String: Any]
    let fileText: String

    init(data: [String: Any], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64) -> Element? {
        guard var typeName = data["key.typename"] as? String else { return nil }
        removeAttributes(typeName: &typeName)
        let typeLength = Int64(typeName.utf16.count)
        let typeOffset = offset + length - typeLength
        return SwiftElement(text: getText(offset: typeOffset, length: typeLength) ?? "", children: [], offset: typeOffset, length: typeLength)
    }

    private func removeAttributes(typeName: inout String) {
        let expressions = ["@escaping\\s*", "@autoclosure\\s*", "@convention\\s*\\(\\s*(swift|c|block)\\s*\\)\\s*"]
        expressions.forEach { e in
            if let range = typeName.range(of: e, options: .regularExpression) {
                typeName = String(typeName[range.upperBound...])
            }
        }
    }
}
