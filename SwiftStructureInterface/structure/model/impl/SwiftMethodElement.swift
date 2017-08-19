class SwiftMethodElement: SwiftElement {

    override func accept(_ visitor: ElementVisitor) {
        visitor.visit(self)
        super.accept(visitor)
    }
}
