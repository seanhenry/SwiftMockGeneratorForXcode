extension DictionaryType {

    public var valueType: Type {
        return last(Type.self) ?? TypeImpl.emptyType()
    }
}
