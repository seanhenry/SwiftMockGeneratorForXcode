class GenericParameterClauseWrapper: ElementWrapper, GenericParameterClause {

    let managedGenericParamterClause: GenericParameterClause

    init(_ element: GenericParameterClause) {
        managedGenericParamterClause = element
        super.init(element)
    }

    var parameters: [GenericParameter] {
        return managedGenericParamterClause.parameters.map(wrap)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitGenericParameterClause(self)
    }
}
