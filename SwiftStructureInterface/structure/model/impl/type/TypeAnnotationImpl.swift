class TypeAnnotationImpl: ElementImpl, TypeAnnotation {

    let attributes: [String]
    let isInout: Bool
    let type: Type

    static let errorTypeAnnotation = TypeAnnotationImpl(text: "", children: [], offset: -1, length: -1, attributes: [], isInout: false, type: TypeImpl.errorType)

    init(text: String, children: [Element], offset: Int64, length: Int64, attributes: [String], isInout: Bool, type: Type) {
        self.attributes = attributes
        self.isInout = isInout
        self.type = type
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypeAnnotation(self)
    }
}
