open class ElementVisitor {

    public init() {}

    open func visitElement(_ element: Element) {
    }

    open func visitTypeDeclaration(_ element: TypeDeclaration) {
        visitElement(element)
    }

    open func visitFile(_ element: File) {
        visitElement(element)
    }

    open func visitType(_ element: Type) {
        visitElement(element)
    }

    open func visitArrayType(_ element: ArrayType) {
        visitType(element)
    }

    open func visitDictionaryType(_ element: DictionaryType) {
        visitType(element)
    }

    open func visitOptionalType(_ element: OptionalType) {
        visitType(element)
    }

    open func visitFunctionDeclaration(_ element: FunctionDeclaration) {
        visitElement(element)
    }

    open func visitVariableDeclaration(_ element: VariableDeclaration) {
        visitElement(element)
    }

    open func visitGenericParameterClause(_ element: GenericParameterClause) {
        visitElement(element)
    }

    open func visitTypealias(_ element: Typealias) {
        visitElement(element)
    }

    open func visitTypealiasAssignment(_ element: TypealiasAssignment) {
        visitElement(element)
    }

    open func visitParameter(_ element: Parameter) {
        visitElement(element)
    }

    open func visitInitialiserDeclaration(_ element: InitialiserDeclaration) {
        visitElement(element)
    }

    open func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
        visitElement(element)
    }
}
