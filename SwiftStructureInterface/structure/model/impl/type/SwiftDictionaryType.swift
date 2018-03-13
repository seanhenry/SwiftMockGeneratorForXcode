class SwiftDictionaryType: SwiftType, DictionaryType {

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
