protocol TypeIdentifier: Type {
    var type: Type { get }
    var genericArguments: [Type] { get }
}
