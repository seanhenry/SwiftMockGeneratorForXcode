class DictionaryTypeImpl: TypeImpl, DictionaryType {

    static let errorDictionaryType = DictionaryTypeImpl(text: "", children: [], offset: -1, length: -1, keyType: TypeImpl.errorType, valueType: TypeImpl.errorType)
    let keyType: Type
    let valueType: Type

    init(text: String, children: [Element], offset: Int64, length: Int64, keyType: Type, valueType: Type) {
        self.keyType = keyType
        self.valueType = valueType
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitDictionaryType(self)
    }
}
