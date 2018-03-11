class RecursiveElementVisitor: ElementVisitor {

    override func visitElement(_ element: Element) {
        element.children.forEach { $0.accept(self) }
    }
}
