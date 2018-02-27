class SwiftTypealias: SwiftElement, Typealias {

    let typeName: String

    init(text: String, children: [Element], offset: Int64, length: Int64, typeName: String) {
        self.typeName = typeName
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
