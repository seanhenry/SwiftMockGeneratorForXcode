class SwiftTypealias: SwiftElement, Typealias {

    let typealiasAssignment: TypealiasAssignment
    let name: String

    init(text: String, children: [Element], offset: Int64, length: Int64, name: String, typealiasAssignment: TypealiasAssignment) {
        self.name = name
        self.typealiasAssignment = typealiasAssignment
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
