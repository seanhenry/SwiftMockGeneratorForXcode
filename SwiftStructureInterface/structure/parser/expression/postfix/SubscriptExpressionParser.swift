class SubscriptExpressionParser: Parser<SubscriptExpression> {

    override func parse() throws -> SubscriptExpression {
        return try SubscriptExpressionImpl(children: builder()
                .required { try self.parsePostfixExpression() }
                .required { try self.parsePunctuation(.leftSquare) }
                .required { try self.parseFunctionCallArgumentList() }
                .optional { try self.parsePunctuation(.rightSquare) }
                .build())
    }
}
