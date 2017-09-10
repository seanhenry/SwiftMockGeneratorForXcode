class SwiftMethodElement: SwiftElement, NamedElement {

    let name: String
    let returnType: String?

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64, returnType: String?) {
        self.name = name
        self.returnType = returnType
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visit(self)
        super.accept(visitor)
    }
}
