extension ConformanceRequirement {

    public var rightTypeIdentifier: TypeIdentifier {
        return last(TypeIdentifier.self) ?? TypeIdentifierImpl.emptyTypeIdentifier()
    }
}
