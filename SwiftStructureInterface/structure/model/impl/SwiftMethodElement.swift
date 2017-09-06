class SwiftMethodElement: SwiftElement {

    let returnType: String?

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64, returnType: String?) {
        self.returnType = returnType
        super.init(name: name, text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visit(self)
        super.accept(visitor)
    }
}
