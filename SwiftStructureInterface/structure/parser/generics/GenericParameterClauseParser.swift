class GenericParameterClauseParser: Parser<GenericParameterClause> {

    override func parse() throws -> GenericParameterClause {
        return try GenericParameterClauseImpl(children: builder()
                .required { try self.parseOperator("<") }
                .optional { try self.parseGenericParameter() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseGenericParameter()
                }
                .optional { try self.parseOperator(">") }
                .build())
    }

    private func parseGenericParameter() throws -> GenericParameter {
        return try GenericParameterImpl(children: builder()
                .required { try self.parseDeclarationIdentifier() }
                .either({ try self.parsePunctuation(.colon) }) {
                    try self.parseBinaryOperator("==")
                }
                .optional { try self.parseType() }
                .build())
    }
}
