class SwiftGenericParameterTypeDeclarationBuilder: SwiftElementBuilderTemplate {

    let fileText: String
    let data: [String: Any]

    init(data: [String: Any], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64) -> Element? {
        return SwiftGenericParameterTypeDeclaration(text: text, children: [], offset: offset, length: length)
    }
}
