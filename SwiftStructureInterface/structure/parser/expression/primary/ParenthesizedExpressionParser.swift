class ParenthesizedExpressionParser: Parser<ParenthesizedExpression> {

    override func parse() throws -> ParenthesizedExpression {
        return try ParenthesizedExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.leftParen) }
                .required { try self.parseExpression() }
                .required { try self.parsePunctuation(.rightParen) }
                .build())
    }
}
