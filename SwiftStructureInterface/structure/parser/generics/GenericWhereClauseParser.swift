class GenericWhereClauseParser: Parser<String> {

    override func parse(offset: Int64) -> String {
        var clause = ""
        if isNext(.where) {
            advance()
            clause.append("where ")
            clause.append(parseRequirementList())
        }
        return clause
    }
}
