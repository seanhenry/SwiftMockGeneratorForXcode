class InitializerExpressionParser: Parser<InitializerExpression> {

    override func parse() throws -> InitializerExpression {
        return try InitializerExpressionImpl(children: builder()
                .required { try self.parsePostfixExpression() }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseKeyword(.init) }
                .optional { try self.parsePunctuation(.leftParen) }
                .optional { try self.parseArgumentNames() }
                .optional { try self.parsePunctuation(.rightParen) }
                .build())
    }
}
