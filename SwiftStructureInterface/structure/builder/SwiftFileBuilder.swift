class SwiftFileBuilder: SwiftElementBuilderTemplate {

    let fileText: String
    let data: [String: Any]

    init(data: [String: Any], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64) -> Element? {
        return SwiftFile(text: fileText, children: buildChildren(), offset: offset, length: length)
    }
}
