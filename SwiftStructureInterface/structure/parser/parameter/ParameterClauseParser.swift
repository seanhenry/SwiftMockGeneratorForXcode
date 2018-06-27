class ParameterClauseParser: Parser<ParameterClause> {

    override func parse() throws -> ParameterClause {
        return try ParameterClauseImpl(children: builder()
                .required { try self.parsePunctuation(.leftParen) }
                .optional { try self.parseParameterUnlessEndOfClause() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseParameterUnlessEndOfClause()
                }
                .optional { try self.parsePunctuation(.rightParen) }
                .build())
    }

    private func parseParameterUnlessEndOfClause() throws -> Element {
        if isNext(.rightParen) {
            throw LookAheadError()
        }
        return try parseParameter()
    }
}
