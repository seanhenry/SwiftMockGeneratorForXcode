class SelectorExpressionParser: Parser<SelectorExpression> {

    override func parse() throws -> SelectorExpression {
        return try SelectorExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.hash) }
                .required { try self.parseStrictIdentifier("selector") }
                .optional { try self.parsePunctuation(.leftParen) }
                .either({ try self.parseStrictIdentifier("getter") }) {
                    try self.parseStrictIdentifier("setter")
                }
                .optional { try self.parsePunctuation(.colon) }
                .optional { try self.parseExpression() }
                .optional { try self.parsePunctuation(.rightParen) }
                .build())
    }
}
