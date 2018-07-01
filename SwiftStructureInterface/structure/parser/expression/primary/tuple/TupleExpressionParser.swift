class TupleExpressionParser: Parser<TupleExpression> {

    override func parse() throws -> TupleExpression {
        return try TupleExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.leftParen) }
                .optional { try self.parseTupleElementList() }
                .optional { try self.parsePunctuation(.rightParen) }
                .build())
    }

    private func parseTupleElementList() throws -> TupleElementList {
        return try TupleElementListImpl(children: builder()
                .optional { try self.parseTupleElement() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseTupleElement()
                }
                .build())
    }

    private func parseTupleElement() throws -> TupleElement {
        return try TupleElementImpl(children: builder()
                .optional { try self.parseIdentifier() }
                .optional { try self.parsePunctuation(.colon) }
                .optional { try self.parseExpression() }
                .build())
    }
}
