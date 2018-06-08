class TypeImpl: ElementImpl, Type {

    static let errorType = TypeImpl(text: "", children: [], offset: -1, length: -1)

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitType(self)
    }
}
