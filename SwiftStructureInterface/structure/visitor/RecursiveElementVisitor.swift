class RecursiveElementVisitor: ElementVisitor {

    private let visitor: ElementVisitor

    init(visitor: ElementVisitor) {
        self.visitor = visitor
    }

    func visit(_ element: SwiftElement) {
        visitor.visit(element)
        element.children.forEach { $0.accept(self) }
    }

    func visit(_ element: SwiftTypeElement) {
        visitor.visit(element)
    }
}
