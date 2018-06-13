class VariableDeclarationWrapper: ElementWrapper, VariableDeclaration {

    let managedVariableDeclaration: VariableDeclaration

    init(_ element: VariableDeclaration) {
        managedVariableDeclaration = element
        super.init(element)
    }

    var type: Type {
        return wrap(managedVariableDeclaration.type)
    }

    var isWritable: Bool {
        return managedVariableDeclaration.isWritable
    }

    var name: String {
        return managedVariableDeclaration.name
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitVariableDeclaration(self)
    }
}
