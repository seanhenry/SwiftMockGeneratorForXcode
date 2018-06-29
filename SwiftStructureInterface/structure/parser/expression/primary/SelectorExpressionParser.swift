class SelectorExpressionParser: Parser<SelectorExpression> {

    override func parse() throws -> SelectorExpression {
        return try SelectorExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.hash) }
                .required { try self.parseIdentifier("selector") }
                .optional { try self.parsePunctuation(.leftParen) }
                .either({ try self.parseIdentifier("getter") }) {
                    try self.parseIdentifier("setter")
                }
                .optional { try self.parsePunctuation(.colon) }
                .optional { try self.parseExpression() }
                .optional { try self.parsePunctuation(.rightParen) }
                .build())
    }
}
