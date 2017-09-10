import SourceKittenFramework

class SwiftFileBuilder: SKSwiftElement {

    let fileText: String
    let data: [String: SourceKitRepresentable]

    init(data: [String: SourceKitRepresentable], fileText: String) {
        self.data = data
        self.fileText = fileText
    }

    func build() -> SwiftFile {
        return SwiftFile(name: getName(), text: fileText, children: buildChildren(), offset: getOffset(), length: getLength())
    }
}
