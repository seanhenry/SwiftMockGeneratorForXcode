class GenericWhereClauseParser: Parser<String> {

    override func parse() -> String {
        var clause = ""
        if isNext(.where) {
            advance()
            clause += "where \(parseRequirementList())"
        }
        return clause
    }
}
