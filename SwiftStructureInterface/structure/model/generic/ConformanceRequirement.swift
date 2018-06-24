public protocol ConformanceRequirement: Requirement {
    var rightTypeIdentifier: TypeIdentifier { get }
    var rightProtocolCompositionType: ProtocolCompositionType { get }
}
