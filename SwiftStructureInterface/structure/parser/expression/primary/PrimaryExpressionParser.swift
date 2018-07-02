class PrimaryExpressionParser: Parser<PrimaryExpression> {

    override func parse() throws -> PrimaryExpression {
        if let expression = try? parseWildcardExpression() {
            return expression
        } else if let expression = try? parseIdentifierExpression() {
            return expression
        } else if let expression = try? parseSelfExpression() {
            return expression
        } else if let expression = try? parseSuperclassExpression() {
            return expression
        } else if let expression = try? parseLiteralExpression() {
            return expression
        } else if let expression = try? parseClosureExpression() {
            return expression
        } else if let expression = try? parseParenthesizedExpression() {
            return expression
        } else if let expression = try? parseTupleExpression() {
            return expression
        } else if let expression = try? parseImplicitMemberExpression() {
            return expression
        } else if let expression = try? parseKeyPathExpression() {
            return expression
        } else if let expression = try? parseSelectorExpression() {
            return expression
        } else if let expression = try? parseKeyPathStringExpression() {
            return expression
        }
        throw LookAheadError()
    }

    private func parseIdentifierExpression() throws -> IdentifierPrimaryExpression {
        return try parse(IdentifierPrimaryExpressionParser.self)
    }

    private func parseLiteralExpression() throws -> LiteralExpression {
        return try parse(LiteralExpressionParser.self)
    }

    private func parseSelfExpression() throws -> SelfExpression {
        return try parse(SelfExpressionParser.self)
    }

    private func parseSuperclassExpression() throws -> SuperclassExpression {
        return try parse(SuperclassExpressionParser.self)
    }

    private func parseParenthesizedExpression() throws -> ParenthesizedExpression {
        return try parse(ParenthesizedExpressionParser.self)
    }

    private func parseTupleExpression() throws -> TupleExpression {
        return try parse(TupleExpressionParser.self)
    }

    private func parseImplicitMemberExpression() throws -> ImplicitMemberExpression {
        return try parse(ImplicitMemberExpressionParser.self)
    }

    private func parseWildcardExpression() throws -> WildcardExpression {
        return try parse(WildcardExpressionParser.self)
    }

    private func parseKeyPathExpression() throws -> KeyPathExpression {
        return try parse(KeyPathExpressionParser.self)
    }

    private func parseSelectorExpression() throws -> SelectorExpression {
        return try parse(SelectorExpressionParser.self)
    }

    private func parseKeyPathStringExpression() throws -> KeyPathStringExpression {
        return try parse(KeyPathStringExpressionParser.self)
    }
}
