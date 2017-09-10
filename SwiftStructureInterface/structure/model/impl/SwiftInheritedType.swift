class SwiftInheritedType: SwiftElement, NamedElement {
    let name: String

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64) {
        self.name = name
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
