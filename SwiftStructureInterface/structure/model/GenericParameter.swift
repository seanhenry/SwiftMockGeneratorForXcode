public protocol GenericParameter: NamedElement {
    var typeIdentifier: TypeIdentifier? { get }
    var protocolComposition: ProtocolCompositionType? { get }
}
