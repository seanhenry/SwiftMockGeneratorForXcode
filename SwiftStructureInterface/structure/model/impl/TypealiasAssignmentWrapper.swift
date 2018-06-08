class TypeAliasAssignmentWrapper<T: TypealiasAssignment>: ElementWrapper<T>, TypealiasAssignment {

    var type: Type {
        return managed.type
    }
}
