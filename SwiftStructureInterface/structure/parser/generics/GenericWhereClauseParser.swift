class GenericWhereClauseParser: Parser<GenericWhereClause> {

    override func parse() throws -> GenericWhereClause {
        return try GenericWhereClauseImpl(children: builder()
                .required { try self.parseKeyword(.where) }
                .optional { try self.parseRequirementList() }
                .build())
    }
}
