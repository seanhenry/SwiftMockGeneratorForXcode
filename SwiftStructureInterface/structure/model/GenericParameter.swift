public protocol GenericParameter: Element {
    var typeName: String { get }
    var typeIdentifier: TypeIdentifier? { get }
    var protocolComposition: ProtocolCompositionType? { get }
}
