extension TupleTypeElement {

    public var label: String? {
        return first(Identifier.self)?.text
    }
}
