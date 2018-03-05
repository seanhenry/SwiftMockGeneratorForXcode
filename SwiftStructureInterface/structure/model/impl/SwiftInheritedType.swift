class SwiftInheritedType: SwiftElement, NamedElement {

    static let error = SwiftInheritedType(name: "", text: "", children: [], offset: -1, length: -1)
    let name: String

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64) {
        self.name = name
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
