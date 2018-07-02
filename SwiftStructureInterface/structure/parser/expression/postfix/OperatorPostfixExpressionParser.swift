class OperatorPostfixExpressionParser: CompoundPostfixExpressionParser<OperatorPostfixExpression> {

    override func parse() throws -> OperatorPostfixExpression {
        return try OperatorPostfixExpressionImpl(children: builder()
                .required { self.postfixExpression }
                .required { try self.parsePostfixOperator() }
                .build())
    }
}
