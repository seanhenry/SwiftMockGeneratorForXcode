class TypealiasWrapper: ElementWrapper, Typealias {

    let managedTypealias: Typealias

    init(_ element: Typealias) {
        managedTypealias = element
        super.init(element)
    }

    var typealiasAssignment: TypealiasAssignment {
        return wrap(managedTypealias.typealiasAssignment)
    }

    var name: String {
        return managedTypealias.name
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypealias(self)
    }
}
