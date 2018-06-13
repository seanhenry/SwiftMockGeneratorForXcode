class TypealiasAssignmentWrapper: ElementWrapper, TypealiasAssignment {

    let managedTypealiasAssignment: TypealiasAssignment

    init(_ element: TypealiasAssignment) {
        managedTypealiasAssignment = element
        super.init(element)
    }

    var type: Type {
        return wrap(managedTypealiasAssignment.type)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypealiasAssignment(self)
    }
}
