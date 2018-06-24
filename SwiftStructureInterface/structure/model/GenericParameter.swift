public protocol GenericParameter: Element {
    var typeIdentifier: TypeIdentifier? { get }
    var protocolComposition: ProtocolCompositionType? { get }
}
