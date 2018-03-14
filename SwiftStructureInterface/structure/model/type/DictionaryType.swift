public protocol DictionaryType: Type {
    var keyType: Type { get }
    var valueType: Type { get }
}
