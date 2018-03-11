class SwiftOptionalType: SwiftType, OptionalType {

    let type: Type

    init(text: String, children: [Element], offset: Int64, length: Int64, type: Type) {
        self.type = type
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
