extension NamedElement {

    public var name: String {
        return children.first { $0 is Identifier }?.text ?? ""
    }
}
