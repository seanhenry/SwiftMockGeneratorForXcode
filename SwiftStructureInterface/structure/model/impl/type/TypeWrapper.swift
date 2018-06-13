class TypeWrapper: ElementWrapper, Type {

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitType(self)
    }
}
