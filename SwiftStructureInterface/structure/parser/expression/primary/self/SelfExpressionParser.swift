class SelfExpressionParser: Parser<SelfExpression> {

    override func parse() throws -> SelfExpression {
        guard isNext(.`self`) else {
            throw LookAheadError()
        }
        if let expression = parseSelfInitializerExpression()
                ?? parseSubscriptSelfExpression()
                ?? parseSelfMethodExpression()
                ?? parseBasicSelfExpression() {
            return expression
        }
        throw LookAheadError()
    }

    private func parseSelfMethodExpression() -> SelfExpression? {
        return try? SelfMethodExpressionImpl(children: builder()
                .required { try self.parseKeyword(.`self`) }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseIdentifier() }
                .build())
    }

    private func parseSelfInitializerExpression() -> SelfExpression? {
        return try? SelfInitializerExpressionImpl(children: builder()
                .required { try self.parseKeyword(.`self`) }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseKeyword(.init) }
                .build())
    }

    private func parseBasicSelfExpression() -> SelfExpression? {
        return try? SelfExpressionImpl(children: self.builder()
                .required { try self.parseKeyword(.`self`) }
                .build())
    }

    private func parseSubscriptSelfExpression() -> SelfExpression? {
        return try? SelfSubscriptExpressionImpl(children: self.builder()
                .required { try self.parseKeyword(.`self`) }
                .required { try self.parsePunctuation(.leftSquare) }
                .optional { try self.parseFunctionCallArgumentList() }
                .optional { try self.parsePunctuation(.rightSquare) }
                .build())
    }
}
