extension InitializerDeclaration {

    public var `throws`: Bool {
        return children.filter { $0 is LeafNode }
                .contains { $0.text == "throws" }
    }

    public var `rethrows`: Bool {
        return children.filter { $0 is LeafNode }
                .contains { $0.text == "rethrows" }
    }

    public var isFailable: Bool {
        return children.filter { $0 is LeafNode }
                .first { $0.text == "?" || $0.text == "!" } != nil
    }
}
