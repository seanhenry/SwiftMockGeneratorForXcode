class OperatorPostfixExpressionParser: Parser<OperatorPostfixExpression> {

    override func parse() throws -> OperatorPostfixExpression {
        return try OperatorPostfixExpressionImpl(children: builder()
                .required { try self.parsePostfixExpression() }
                .required { try self.parsePostfixOperator() }
                .build())
    }
}
