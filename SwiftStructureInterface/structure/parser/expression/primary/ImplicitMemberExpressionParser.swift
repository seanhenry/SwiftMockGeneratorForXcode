class ImplicitMemberExpressionParser: Parser<ImplicitMemberExpression> {

    override func parse() throws -> ImplicitMemberExpression {
        return try ImplicitMemberExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseIdentifier() }
                .build())
    }
}
