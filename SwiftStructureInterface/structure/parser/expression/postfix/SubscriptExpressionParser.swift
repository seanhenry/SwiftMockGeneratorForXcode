class SubscriptExpressionParser: CompoundPostfixExpressionParser<SubscriptExpression> {

    override func parse() throws -> SubscriptExpression {
        return try SubscriptExpressionImpl(children: builder()
                .required { self.postfixExpression }
                .required { try self.parsePunctuation(.leftSquare) }
                .required { try self.parseFunctionCallArgumentList() }
                .optional { try self.parsePunctuation(.rightSquare) }
                .build())
    }
}
