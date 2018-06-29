class ForcedValueExpressionParser: Parser<ForcedValueExpression> {

    override func parse() throws -> ForcedValueExpression {
        return try ForcedValueExpressionImpl(children: builder()
                .required { try self.parsePostfixExpression() }
                .required { try self.parseOperator("!") }
                .build())
    }
}
