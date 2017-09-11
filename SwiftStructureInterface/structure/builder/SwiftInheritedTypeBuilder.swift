import SourceKittenFramework

class SwiftInheritedTypeBuilder: NamedSwiftElementBuilderTemplate {
    
    static let kind = "SwiftInheritedTypeBuilder.inheritedType"
    let data: [String: SourceKitRepresentable]
    let fileText: String

    init(data: [String: SourceKitRepresentable], fileText: String) {
        self.data = data
        self.fileText = fileText
    }
    
    func build(text: String, offset: Int64, length: Int64, name: String) -> Element? {
        return SwiftInheritedType(name: name, text: text, children: buildChildren(), offset: offset, length: length)
    }
}
