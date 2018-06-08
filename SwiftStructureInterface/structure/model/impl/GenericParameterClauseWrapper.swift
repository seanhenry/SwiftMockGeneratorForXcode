class GenericParameterClauseWrapper<T: GenericParameterClause>: ElementWrapper<T>, GenericParameterClause {

    var parameters: [GenericParameter] {
        return managed.parameters
    }
}
