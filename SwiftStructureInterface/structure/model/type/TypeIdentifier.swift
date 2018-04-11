public protocol TypeIdentifier: Type {
    var parentType: TypeIdentifier? { get }
    var typeName: String { get }
    var genericArguments: [Type] { get }
}
