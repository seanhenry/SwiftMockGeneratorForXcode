extension TypeAnnotation {

    public var isInout: Bool {
        return children.contains { $0 === Keywords.inout }
    }
}
