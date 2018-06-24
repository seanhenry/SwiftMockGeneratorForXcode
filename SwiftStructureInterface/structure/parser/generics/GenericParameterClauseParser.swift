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

    private func parseGenericParameterList() -> [Element?] {
        var parameterList = [Element?]()
        parameterList.append(parseGenericParameter())
        while isNext(.comma) {
            parameterList.append(parseWhitespace())
            parameterList.append(try? parsePunctuation(.comma))
            parameterList.append(parseWhitespace())
            parameterList.append(parseGenericParameter())
        }
        return parameterList
    }

    private func parseGenericParameter() -> GenericParameter {
        guard let typeName = try? parseIdentifier() else {
            return GenericParameterImpl.emptyGenericParameter
        }
        return GenericParameterImpl(children: [
            typeName,
            parseSymbol(),
            parseType()
        ])
    }

    private func parseSymbol() -> [Element] {
        let whitespace = parseWhitespace()
        let colon = try? parsePunctuation(.colon)
        let sameType = try? parseBinaryOperator("==")
        if let symbol = colon ?? sameType {
            return [
                whitespace,
                symbol,
                parseWhitespace()
            ]
        }
        return []
    }
}
