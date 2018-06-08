class VariableDeclarationWrapper<T: VariableDeclaration>: ElementWrapper<T>, VariableDeclaration {

    var type: Type {
        return managed.type
    }

    var isWritable: Bool {
        return managed.isWritable
    }

    var name: String {
        return managed.name
    }
}
