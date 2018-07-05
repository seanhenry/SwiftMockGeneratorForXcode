class IdentifierPrimaryExpressionParser: Parser<IdentifierPrimaryExpression> {

    override func parse() throws -> IdentifierPrimaryExpression {
        return try IdentifierPrimaryExpressionImpl(children: builder()
                .required { try self.parseDeclarationIdentifier() }
                .optional { try self.parseGenericParameterClause() }
                .build())
    }
}
