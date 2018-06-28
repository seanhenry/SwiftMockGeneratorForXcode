extension NamedElement {

    public var name: String {
        return first(Identifier.self)?.text ?? ""
    }
}
