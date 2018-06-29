class OptionalChainingExpressionParser: Parser<OptionalChainingExpression> {

    override func parse() throws -> OptionalChainingExpression {
        return try OptionalChainingExpressionImpl(children: builder()
                .required { try self.parsePostfixExpression() }
                .required { try self.parseOperator("?") }
                .build())
    }
}
