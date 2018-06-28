class SuperclassExpressionParser: Parser<SuperclassExpression> {

    override func parse() throws -> SuperclassExpression {
        if let expression = parseSuperclassMethodExpression()
                ?? parseSuperclassInitializerExpression() {
            return expression
        }
        throw LookAheadError()
    }

    private func parseSuperclassMethodExpression() -> SuperclassExpression? {
        return try? SuperclassMethodExpressionImpl(children: builder()
                .required { try self.parseKeyword(.`super`) }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseIdentifier() }
                .build())
    }

    private func parseSuperclassInitializerExpression() -> SuperclassExpression? {
        return try? SuperclassInitializerExpressionImpl(children: builder()
                .required { try self.parseKeyword(.`super`) }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseKeyword(.init) }
                .build())
    }
}
