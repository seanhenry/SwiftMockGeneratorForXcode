extension TupleTypeElement {

    public var label: String? {
        return (children.first { $0 is Identifier } as? Identifier)?.text
    }
}
