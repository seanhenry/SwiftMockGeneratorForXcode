open class RecursiveElementVisitor: ElementVisitor {

    override open func visitElement(_ element: Element) {
        element.children.forEach { $0.accept(self) }
    }
}
