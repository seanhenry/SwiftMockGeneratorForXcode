extension TypeAnnotation {

    public var isInout: Bool {
        return contains(Keywords.inout)
    }
}
