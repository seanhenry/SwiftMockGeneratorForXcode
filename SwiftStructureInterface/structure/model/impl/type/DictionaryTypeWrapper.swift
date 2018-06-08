class DictionaryTypeWrapper<T: DictionaryType>: TypeWrapper<T>, DictionaryType {

    var keyType: Type {
        return managed.keyType
    }

    var valueType: Type {
        return managed.valueType
    }
}
