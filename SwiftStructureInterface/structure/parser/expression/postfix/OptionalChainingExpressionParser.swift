class OptionalChainingExpressionParser: CompoundPostfixExpressionParser<OptionalChainingExpression> {

    override func parse() throws -> OptionalChainingExpression {
        return try OptionalChainingExpressionImpl(children: builder()
                .required { self.postfixExpression }
                .required { try self.parsePunctuation(.postfixQuestion) }
                .build())
    }
}
