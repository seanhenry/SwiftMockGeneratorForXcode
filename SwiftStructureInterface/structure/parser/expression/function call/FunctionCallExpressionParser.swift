class FunctionCallExpressionParser: CompoundPostfixExpressionParser<FunctionCallExpression> {

    override func parse() throws -> FunctionCallExpression {
        return try FunctionCallExpressionImpl(children: builder()
                .required { self.postfixExpression }
                .check { try self.isNextClauseOrTrailingClosure() }
                .optional { try self.parseFunctionCallArgumentListClause() }
                .optional { try self.parseClosureExpression() }
                .build())
    }

    private func isNextClauseOrTrailingClosure() throws {
        guard isNext([.leftParen, .leftBrace]) else {
            throw LookAheadError()
        }
    }

    private func parseFunctionCallArgumentListClause() throws -> FunctionCallArgumentClause {
        return try FunctionCallArgumentClauseImpl(children: builder()
                .required { try self.parsePunctuation(.leftParen) }
                .optional { try self.parseFunctionCallArgumentList() }
                .optional { try self.parsePunctuation(.rightParen) }
                .build())
    }
}
