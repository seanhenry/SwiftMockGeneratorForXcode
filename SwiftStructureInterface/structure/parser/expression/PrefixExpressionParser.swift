class PrefixExpressionParser: Parser<PrefixExpression> {

    override func parse() throws -> PrefixExpression {
        if isNext(.prefixAmp) {
            return try parseInOutExpression()
        }
        return try PrefixExpressionImpl(children: builder()
                .optional { try self.parsePrefixOperator() }
                .required { try self.parsePostfixExpression() }
                .build())
    }
}
