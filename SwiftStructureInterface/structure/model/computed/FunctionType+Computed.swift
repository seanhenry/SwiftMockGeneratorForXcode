extension FunctionType {

    public var `throws`: Bool {
        return children.contains { $0.text == Keywords.throws }
    }

    public var `rethrows`: Bool {
        return children.contains { $0.text == Keywords.rethrows }
    }
}
