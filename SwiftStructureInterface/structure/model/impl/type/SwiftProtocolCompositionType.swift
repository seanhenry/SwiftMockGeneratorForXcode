class SwiftProtocolCompositionType: SwiftType, ProtocolCompositionType {

    static let errorProtocolCompositionType = SwiftProtocolCompositionType(text: "", children: [], offset: -1, length: -1, types: [])
    let types: [Type]

    init(text: String, children: [Element], offset: Int64, length: Int64, types: [Type]) {
        self.types = types
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
