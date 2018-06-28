extension TypeIdentifier {

    public var typeName: String {
        return first(Identifier.self)?.text ?? ""
    }
}
