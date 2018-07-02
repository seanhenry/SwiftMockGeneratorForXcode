class DefaultArgumentClauseParser: Parser<DefaultArgumentClause> {

    override func parse() throws -> DefaultArgumentClause {
        if !isNext(.assignmentOperator) {
            throw LookAheadError()
        }
        return try DefaultArgumentClauseImpl(children: builder()
                .optional { try self.parseOperator() }
                .optional { try self.parseExpression() }
                .build())
    }
}
