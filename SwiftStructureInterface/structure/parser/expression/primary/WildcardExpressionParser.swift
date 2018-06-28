class WildcardExpressionParser: Parser<WildcardExpression> {

    override func parse() throws -> WildcardExpression {
        return try WildcardExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.underscore) }
                .build())
    }
}
