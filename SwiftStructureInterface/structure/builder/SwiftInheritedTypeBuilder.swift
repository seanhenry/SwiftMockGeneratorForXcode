class SwiftInheritedTypeBuilder: SwiftElementBuilderTemplate {
    
    static let kind = "SwiftInheritedTypeBuilder.inheritedType"
    let data: [String: Any]
    let fileText: String

    init(data: [String: Any], fileText: String) {
        self.data = data
        self.fileText = fileText
    }
    
    func build(text: String, offset: Int64, length: Int64) -> Element? {
        return SwiftType(text: text, children: buildChildren(), offset: offset, length: length)
    }
}
