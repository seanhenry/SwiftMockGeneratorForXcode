class TupleTypeImpl: TypeImpl, TupleType {

    let elements: [TupleTypeElement]
    static let errorTupleType = TupleTypeImpl(text: "", children: [], offset: -1, length: -1, elements: [])

    init(text: String, children: [Element], offset: Int64, length: Int64, elements: [TupleTypeElement]) {
        self.elements = elements
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTupleType(self)
    }
}