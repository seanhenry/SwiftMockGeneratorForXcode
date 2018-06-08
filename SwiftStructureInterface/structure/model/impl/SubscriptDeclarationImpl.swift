class SubscriptDeclarationImpl: ElementImpl, SubscriptDeclaration {

    static let errorSubscriptDeclaration = SubscriptDeclarationImpl(text: "", children: [], offset: -1, length: -1)

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitSubscriptDeclaration(self)
    }
}
