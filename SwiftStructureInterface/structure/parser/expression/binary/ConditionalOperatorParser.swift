class ConditionalOperatorParser: Parser<ConditionalOperator> {

    override func parse() throws -> ConditionalOperator {
        return try ConditionalOperatorImpl(children: builder()
                .required { try self.parseOperator("?") }
                .optional { try self.parseExpression() }
                .required { try self.parsePunctuation(.colon) }
                .build())
    }
}
