class TypeInheritanceClauseParser: Parser<TypeInheritanceClause> {

    override func parse() throws -> TypeInheritanceClause {
        return try TypeInheritanceClauseImpl(children: builder()
                .required { try self.parsePunctuation(.colon) }
                .optional { try self.parseType() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseType()
                }
                .build())
    }
}
