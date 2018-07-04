class ExpressionParser: Parser<Expression> {

    override func parse() throws -> Expression {
        requiredSideEffect()
        return try ExpressionImpl(children: builder()
                .optional { try self.parseTryOperator() }
                .required { try self.parsePrefixExpression() }
                .build())
    }

    private func requiredSideEffect() {
        // For some reason the lexer changes its mind about the prefix operator
        // after trying to parse the `try` keyword.
        _ = peekAtKind(aheadBy: 2)
    }
}
