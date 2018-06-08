class FunctionDeclarationWrapper<T: FunctionDeclaration>: ElementWrapper<T>, FunctionDeclaration {

    var genericParameterClause: GenericParameterClause? {
        return managed.genericParameterClause
    }

    var parameters: [Parameter] {
        return managed.parameters
    }

    var returnType: Element? {
        return managed.returnType
    }

    var `throws`: Bool {
        return managed.`throws`
    }

    var name: String {
        return managed.name
    }
    
    init(managed: T) {
        super.init(managed)
    }
}
