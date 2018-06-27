class GenericArgumentClauseParser: Parser<GenericArgumentClause> {

    override func parse() throws -> GenericArgumentClause {
        guard isNext("<") else {
            throw LookAheadError()
        }
        return try GenericArgumentClauseImpl(children: builder()
                .optional { try self.parseOperator("<") }
                .optional { try self.parseType() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseType()
                }
                .optional { try self.parseOperator(">") }
                .build())
    }
}
