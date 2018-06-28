class BuildElementText: RecursiveElementVisitor {

    static func build(from element: Element) -> String {
        let visitor = BuildElementText()
        element.accept(visitor)
        return visitor.text
    }

    var text = ""

    override func visitLeafNode(_ element: LeafNode) {
        text.append(element.text)
        super.visitElement(element)
    }
}
