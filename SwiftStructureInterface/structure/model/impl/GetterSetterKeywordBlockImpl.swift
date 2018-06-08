class GetterSetterKeywordBlockImpl: ElementImpl, GetterSetterKeywordBlock {

    let isWritable: Bool

    static let errorGetterSetterKeywordBlock = GetterSetterKeywordBlockImpl(text: "", children: [], offset: -1, length: -1, isWritable: false)

    init(text: String, children: [Element], offset: Int64, length: Int64, isWritable: Bool) {
        self.isWritable = isWritable
        super.init(text: text, children: children, offset: offset, length: length)
    }
}
