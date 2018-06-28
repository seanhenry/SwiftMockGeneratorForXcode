extension FunctionType {

    public var `throws`: Bool {
        return contains(Keywords.throws)
    }

    public var `rethrows`: Bool {
        return contains(Keywords.rethrows)
    }

    public var returnType: Type {
        return last(Type.self) ?? TypeImpl.emptyType()
    }
}
