class PostfixSelfExpressionParser: Parser<PostfixSelfExpression> {

    override func parse() throws -> PostfixSelfExpression {
        return try PostfixSelfExpressionImpl(children: builder()
                .required { try self.parsePostfixExpression() }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseKeyword(.`self`) }
                .build())
    }
}
