class SwiftGetterSetterBlock: SwiftElement, GetterSetterBlock {

    let isWritable: Bool

    init(text: String, children: [Element], offset: Int64, length: Int64, isWritable: Bool) {
        self.isWritable = isWritable
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
