class GenericWhereClauseParser: Parser<GenericWhereClause> {

    override func parse(start: LineColumn) -> GenericWhereClause {
        guard isNext(.where) else { return GenericWhereClauseImpl.emptyGenericWhereClause }
        return GenericWhereClauseImpl(children: [
            parseKeyword(),
            parseWhitespace(),
            parseRequirementList()
        ])
    }
}
