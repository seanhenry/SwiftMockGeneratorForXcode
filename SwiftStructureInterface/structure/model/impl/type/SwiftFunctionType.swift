class SwiftFunctionType: TypeImpl, FunctionType {

    let attributes: [String]
    let arguments: TupleType
    let returnType: Element
    let `throws`: Bool
    let `rethrows`: Bool

    init(text: String, children: [Element], offset: Int64, length: Int64, attributes: [String], arguments: TupleType, returnType: Element, `throws`: Bool, `rethrows`: Bool) {
        self.attributes = attributes
        self.arguments = arguments
        self.returnType = returnType
        self.throws = `throws`
        self.rethrows = `rethrows`
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitFunctionType(self)
    }
}
