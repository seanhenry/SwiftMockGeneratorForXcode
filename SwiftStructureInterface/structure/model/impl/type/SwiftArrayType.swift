class SwiftArrayType: SwiftType, ArrayType {

    let elementType: Type

    init(text: String, children: [Element], offset: Int64, length: Int64, elementType: Type) {
        self.elementType = elementType
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitArrayType(self)
    }
}
