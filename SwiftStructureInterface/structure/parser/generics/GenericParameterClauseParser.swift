class GenericParameterClauseParser: Parser<GenericParameterClause> {

    override func parse(start: LineColumn) -> GenericParameterClause {
        guard isNext("<") else {
            return GenericParameterClauseImpl.emptyGenericParameterClause
        }
        return GenericParameterClauseImpl(children: [
            try? parseOperator("<"),
            parseWhitespace(),
            parseGenericParameterList(),
            parseWhitespace(),
            try? parseOperator(">")
        ])
    }

    private func parseGenericParameterList() -> [GenericParameter] {
        var parameterList = [GenericParameter]()
        repeat {
            advance(if: .comma)
            parameterList.append(parseGenericParameter())
        } while isNext(.comma)
        return parameterList
    }

    private func parseGenericParameter() -> GenericParameter {
        let offset = getCurrentStartLocation()
        guard let typeName = try? parseIdentifier() else {
            return GenericParameterImpl.emptyGenericParameter
        }
        return GenericParameterImpl(children: [
            typeName,
            parseWhitespace(),
            parseSymbol(),
            parseWhitespace(),
            parseType()
        ])
    }

    private func parseSymbol() -> Element {
        return (try? parsePunctuation(.colon)) ?? LeafNodeImpl(text: "")
    }
}
