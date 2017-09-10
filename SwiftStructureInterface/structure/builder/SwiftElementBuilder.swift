import SourceKittenFramework

class SwiftElementBuilder: SKSwiftElement {

    let fileText: String
    let data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build() -> SwiftElement {
        let offset = getOffset()
        let length = getLength()
        let text = getText(offset: offset, length: length)
        return SwiftElement(name: getName(), text: text, children: buildChildren(), offset: offset, length: length)
    }
}
