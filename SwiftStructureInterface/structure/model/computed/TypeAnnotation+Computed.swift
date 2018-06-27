extension TypeAnnotation {

    public var isInout: Bool {
        return children.contains { $0.text == Keywords.inout }
    }
}
