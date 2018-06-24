class GenericArgumentClauseParser: Parser<GenericArgumentClause> {

    override func parse(start: LineColumn) -> GenericArgumentClause {
        guard isNext("<") else {
            return GenericArgumentClauseImpl.emptyGenericArgumentClause
        }
        return GenericArgumentClauseImpl(children: [
            try? parseOperator("<"),
            parseWhitespace(),
            parseTypes(),
            parseWhitespace(),
            try? parseOperator(">")
        ])
    }

    private func parseTypes() -> [Element?] {
        var types = [Element?]()
        types.append(parseType())
        while isNext(.comma) {
            types.append(parseWhitespace())
            types.append(try? parsePunctuation(.comma))
            types.append(parseWhitespace())
            types.append(parseType())
        }
        return types
    }
}
