class SwiftMethodElement: SwiftElement, NamedElement {

    static let errorMethodElement = SwiftMethodElement(name: "", text: "", children: [], offset: -1, length: -1, returnType: nil, parameters: [])
    let name: String
    let returnType: Element?
    let parameters: [MethodParameter]

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64, returnType: Element?, parameters: [MethodParameter]) {
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
