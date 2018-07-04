class BinaryExpressionParser: Parser<BinaryExpression> {

    override func parse() throws -> BinaryExpression {
        if case .binaryOperator(_) = peekAtNextKind() {
            return try BinaryExpressionImpl(children: builder()
                    .required { try self.parseOperator() }
                    .required { try self.parsePrefixExpression() }
                    .build())
        } else if isNext(.assignmentOperator) {
            return try BinaryExpressionImpl(children: builder()
                    .required { try self.parsePunctuation(.assignmentOperator) }
                    .optional { try self.parseTryOperator() }
                    .required { try self.parsePrefixExpression() }
                    .build())
        } else if isNext(.binaryQuestion) {
            return try BinaryExpressionImpl(children: builder()
                    .required { try self.parseConditionalOperator() }
                    .optional { try self.parseTryOperator() }
                    .required { try self.parsePrefixExpression() }
                    .build())
        } else if isNext([.as, .is]) {
            return try BinaryExpressionImpl(children: builder()
                    .required { try self.parseTypeCastingOperator() }
                    .build())
        }
        throw LookAheadError()
    }
}
