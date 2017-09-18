class SwiftMethodElement: SwiftElement, NamedElement {

    let name: String
    let returnType: String?
    let parameters: [MethodParameter]

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64, returnType: String?, parameters: [MethodParameter]) {
        self.name = name
        self.returnType = returnType
        self.parameters = parameters
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visit(self)
        super.accept(visitor)
    }
}
