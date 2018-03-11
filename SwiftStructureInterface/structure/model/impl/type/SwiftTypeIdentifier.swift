class SwiftTypeIdentifier: SwiftType, TypeIdentifier {

    let type: Type
    let genericArguments: [Type]

    init(text: String, children: [Element], offset: Int64, length: Int64, type: Type, genericArguments: [Type]) {
        self.type = type
        self.genericArguments = genericArguments
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
