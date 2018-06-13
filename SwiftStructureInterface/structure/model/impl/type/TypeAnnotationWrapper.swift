class TypeAnnotationWrapper: ElementWrapper, TypeAnnotation {

    let managedTypeAnnotation: TypeAnnotation

    init(_ element: TypeAnnotation) {
        managedTypeAnnotation = element
        super.init(element)
    }

    var attributes: [String] {
        return managedTypeAnnotation.attributes
    }

    var isInout: Bool {
        return managedTypeAnnotation.isInout
    }

    var type: Type {
        return wrap(managedTypeAnnotation.type)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypeAnnotation(self)
    }
}
