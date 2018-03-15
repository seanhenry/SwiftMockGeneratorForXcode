class GenericWhereClauseParser: Parser<String> {

    override func parse(start: LineColumn) -> String {
        var clause = ""
        if isNext(.where) {
            advance()
            clause.append("where ")
            clause.append(parseRequirementList())
        }
        return clause
    }
}
