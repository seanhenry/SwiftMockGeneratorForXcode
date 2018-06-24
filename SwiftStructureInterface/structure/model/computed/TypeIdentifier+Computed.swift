extension TypeIdentifier {

    public var typeName: String {
        return children.first { $0 is Identifier }?.text ?? ""
    }
}
