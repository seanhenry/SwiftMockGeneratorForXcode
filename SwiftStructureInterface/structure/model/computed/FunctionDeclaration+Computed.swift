extension FunctionDeclaration {

    public var name: String {
        return children.first { $0 is Identifier }?.text ?? ""
    }

    public var `throws`: Bool {
        return children.compactMap { $0 as? LeafNode }.contains { $0.text == "throws" }
    }
}
