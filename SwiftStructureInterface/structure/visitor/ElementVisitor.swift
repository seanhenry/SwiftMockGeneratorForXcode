class ElementVisitor {

    func visitElement(_ element: Element) {
    }

    func visitTypeDeclaration(_ element: TypeDeclaration) {
        visitElement(element)
    }

    func visitFile(_ element: File) {
        visitElement(element)
    }

    func visitType(_ element: Type) {
        visitElement(element)
    }

    func visitFunctionDeclaration(_ element: FunctionDeclaration) {
        visitElement(element)
    }

    func visitVariableDeclaration(_ element: VariableDeclaration) {
        visitElement(element)
    }

    func visitGenericParameterClause(_ element: GenericParameterClause) {
        visitElement(element)
    }

    func visitTypealias(_ element: Typealias) {
        visitElement(element)
    }

    func visitTypealiasAssignment(_ element: TypealiasAssignment) {
        visitElement(element)
    }

    func visitParameter(_ element: Parameter) {
        visitElement(element)
    }
}
