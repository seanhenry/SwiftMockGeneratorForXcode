class ForcedValueExpressionParser: CompoundPostfixExpressionParser<ForcedValueExpression> {

    override func parse() throws -> ForcedValueExpression {
        return try ForcedValueExpressionImpl(children: builder()
                .required { self.postfixExpression }
                .required { try self.parseOperator("!") }
                .build())
    }
}
