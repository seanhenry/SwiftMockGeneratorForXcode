class SuperclassExpressionParser: Parser<SuperclassExpression> {

    override func parse() throws -> SuperclassExpression {
        guard isNext(.`super`) else {
            throw LookAheadError()
        }
        if let expression = parseSuperclassInitializerExpression()
                ?? parseSubscriptSuperclassExpression()
                ?? parseSuperclassMethodExpression() {
            return expression
        }
        throw LookAheadError()
    }

    private func parseSuperclassMethodExpression() -> SuperclassExpression? {
        return try? SuperclassMethodExpressionImpl(children: builder()
                .required { try self.parseKeyword(.`super`) }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseDeclarationIdentifier() }
                .build())
    }

    private func parseSuperclassInitializerExpression() -> SuperclassExpression? {
        return try? SuperclassInitializerExpressionImpl(children: builder()
                .required { try self.parseKeyword(.`super`) }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseKeyword(.init) }
                .build())
    }

    private func parseSubscriptSuperclassExpression() -> SuperclassExpression? {
        return try? SuperclassSubscriptExpressionImpl(children: self.builder()
                .required { try self.parseKeyword(.`super`) }
                .required { try self.parsePunctuation(.leftSquare) }
                .optional { try self.parseFunctionCallArgumentList() }
                .optional { try self.parsePunctuation(.rightSquare) }
                .build())
    }
}
