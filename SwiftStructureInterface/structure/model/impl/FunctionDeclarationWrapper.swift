class FunctionDeclarationWrapper: ElementWrapper, FunctionDeclaration {

    let managedFunctionDeclaration: FunctionDeclaration

    init(_ element: FunctionDeclaration) {
        managedFunctionDeclaration = element
        super.init(element)
    }

    var genericParameterClause: GenericParameterClause? {
        return managedFunctionDeclaration.genericParameterClause.flatMap(wrap)
    }

    var parameters: [Parameter] {
        return managedFunctionDeclaration.parameters.map(wrap)
    }

    var returnType: Element? {
        return managedFunctionDeclaration.returnType.flatMap(wrap)
    }

    var `throws`: Bool {
        return managedFunctionDeclaration.`throws`
    }

    var name: String {
        return managedFunctionDeclaration.name
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitFunctionDeclaration(self)
    }
}
