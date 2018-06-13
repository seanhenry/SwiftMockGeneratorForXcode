class SubscriptDeclarationWrapper: ElementWrapper, SubscriptDeclaration {

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitSubscriptDeclaration(self)
    }
}
