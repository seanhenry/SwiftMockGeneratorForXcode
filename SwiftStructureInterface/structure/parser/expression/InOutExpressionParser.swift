class InOutExpressionParser: Parser<InOutExpression> {

    override func parse() throws -> InOutExpression {
        return try InOutExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.prefixAmp) }
                .required { try self.parseIdentifier() }
                .build())
    }
}
