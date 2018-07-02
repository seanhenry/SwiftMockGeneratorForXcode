class PostfixSelfExpressionParser: CompoundPostfixExpressionParser<PostfixSelfExpression> {

    override func parse() throws -> PostfixSelfExpression {
        return try PostfixSelfExpressionImpl(children: builder()
                .required { self.postfixExpression }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseKeyword(.`self`) }
                .build())
    }
}
