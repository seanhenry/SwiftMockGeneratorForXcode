import SourceKittenFramework

class SwiftElementBuilder: SwiftElementBuilderTemplate {

    let fileText: String
    let data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build(text: String, offset: Int64, length: Int64) -> Element? {
        return SwiftElement(text: text, children: buildChildren(), offset: offset, length: length)
    }
}
