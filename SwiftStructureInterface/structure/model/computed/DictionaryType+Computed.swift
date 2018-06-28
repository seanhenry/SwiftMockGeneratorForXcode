extension DictionaryType {

    var valueType: Type {
        return last(Type.self) ?? TypeImpl.emptyType()
    }
}
