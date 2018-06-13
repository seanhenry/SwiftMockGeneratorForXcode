class TupleTypeElementWrapper: ElementWrapper, TupleTypeElement {

    let managedTypleTypeElement: TupleTypeElement

    init(_ element: TupleTypeElement) {
        managedTypleTypeElement = element
        super.init(element)
    }

    var label: String? {
        return managedTypleTypeElement.label
    }

    var typeAnnotation: TypeAnnotation {
        return wrap(managedTypleTypeElement.typeAnnotation)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTupleTypeElement(self)
    }
}
