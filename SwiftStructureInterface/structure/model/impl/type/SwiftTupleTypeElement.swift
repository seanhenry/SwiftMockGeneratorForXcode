class SwiftTupleTypeElement: SwiftElement, TupleTypeElement {

    let label: String?
    let typeAnnotation: TypeAnnotation

    static let errorTupleTypeElement = SwiftTupleTypeElement(text: "", children: [], offset: -1, length: -1, label: nil, typeAnnotation: SwiftTypeAnnotation.errorTypeAnnotation)

    init(text: String, children: [Element], offset: Int64, length: Int64, label: String?, typeAnnotation: TypeAnnotation) {
        self.label = label
        self.typeAnnotation = typeAnnotation
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTupleTypeElement(self)
    }
}
