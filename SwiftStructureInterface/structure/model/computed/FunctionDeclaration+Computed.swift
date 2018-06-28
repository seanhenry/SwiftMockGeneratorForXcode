extension FunctionDeclaration {

    public var name: String {
        return first(Identifier.self)?.text ?? ""
    }

    public var `throws`: Bool {
        return contains(Keywords.throws)
    }
}
