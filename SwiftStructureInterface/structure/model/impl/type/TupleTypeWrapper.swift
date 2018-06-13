class TupleTypeWrapper: TypeWrapper, TupleType {

    let managedTupleType: TupleType

    init(_ element: TupleType) {
        managedTupleType = element
        super.init(element)
    }

    var elements: [TupleTypeElement] {
        return managedTupleType.elements.map(wrap)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTupleType(self)
    }
}
