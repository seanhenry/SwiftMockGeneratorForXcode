class SwiftSubscriptDeclaration: ElementImpl, SubscriptDeclaration {

    static let errorSubscriptDeclaration = SwiftSubscriptDeclaration(text: "", children: [], offset: -1, length: -1)

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitSubscriptDeclaration(self)
    }
}
