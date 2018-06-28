extension ConformanceRequirement {

    public var rightTypeIdentifier: TypeIdentifier {
        return children.reversed().first { $0 is TypeIdentifier } as? TypeIdentifier ?? TypeIdentifierImpl.emptyTypeIdentifier()
    }
}
