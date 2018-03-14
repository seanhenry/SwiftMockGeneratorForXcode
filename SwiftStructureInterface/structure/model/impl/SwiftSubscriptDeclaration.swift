class SwiftSubscriptDeclaration: SwiftElement, SubscriptDeclaration {

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitSubscriptDeclaration(self)
    }
}
