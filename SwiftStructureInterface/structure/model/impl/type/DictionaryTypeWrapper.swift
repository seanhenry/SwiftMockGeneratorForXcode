class DictionaryTypeWrapper: TypeWrapper, DictionaryType {

    let managedDictionaryType: DictionaryType

    init(_ element: DictionaryType) {
        managedDictionaryType = element
        super.init(element)
    }

    var keyType: Type {
        return wrap(managedDictionaryType.keyType)
    }

    var valueType: Type {
        return wrap(managedDictionaryType.valueType)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitDictionaryType(self)
    }
}
