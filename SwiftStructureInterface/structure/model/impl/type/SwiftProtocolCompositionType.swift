class SwiftProtocolCompositionType: SwiftType, ProtocolCompositionType {

    let types: [Type]

    init(text: String, children: [Element], offset: Int64, length: Int64, types: [Type]) {
        self.types = types
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
