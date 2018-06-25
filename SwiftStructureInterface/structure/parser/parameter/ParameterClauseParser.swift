class ParameterClauseParser: Parser<ParameterClause> {

    override func parse(start: LineColumn) -> ParameterClause {
        var children = [Any?]()
        children.append(tryToParsePunctuation(.leftParen))
        if isNext(.rightParen) {
            children.append(try? parsePunctuation(.rightParen))
            return ParameterClauseImpl(children: children)
        }
        children.append(parseParameter())
        while isNext(.comma) {
            children.append(tryToParsePunctuation(.comma))
            children.append(parseParameter())
        }
        children.append(tryToParsePunctuation(.rightParen))
        return ParameterClauseImpl(children: children)
    }

    private func tryToAppendParameter(to parameters: inout [Parameter]) {
        parameters.append(parseParameter())
    }
}
