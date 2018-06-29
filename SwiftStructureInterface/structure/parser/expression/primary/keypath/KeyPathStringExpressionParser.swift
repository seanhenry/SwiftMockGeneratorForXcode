class KeyPathStringExpressionParser: Parser<KeyPathStringExpression> {

    override func parse() throws -> KeyPathStringExpression {
        return try KeyPathStringExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.hash) }
                .required { try self.parseIdentifier("keyPath") }
                .optional { try self.parsePunctuation(.leftParen) }
                .optional { try self.parseExpression() }
                .optional { try self.parsePunctuation(.rightParen) }
                .build())
    }
}
