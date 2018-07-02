class PostfixExpressionParser: Parser<PostfixExpression> {

    override func parse() throws -> PostfixExpression {
        if let expression = try? parseFunctionCallExpression() {
            return expression
        } else if let expression = try? parseInitializerExpression() {
            return expression
        } else if let expression = try? parseExplicitMemberExpression() {
            return expression
        } else if let expression = try? parsePostfixSelfExpression() {
            return expression
        } else if let expression = try? parseSubscriptExpression() {
            return expression
        } else if let expression = try? parseForcedValueExpression() {
            return expression
        } else if let expression = try? parseOptionalChainingExpression() {
            return expression
        } else if let expression = try? parseOperatorPostfixExpression() {
            return expression
        } else if let expression = try? parseWildcardExpression() {
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

    private func parseFunctionCallExpression() throws -> FunctionCallExpression {
        return try parse(FunctionCallExpressionParser.self)
    }

    private func parseInitializerExpression() throws -> InitializerExpression {
        return try parse(InitializerExpressionParser.self)
    }

    private func parseExplicitMemberExpression() throws -> ExplicitMemberExpression {
        return try parse(ExplicitMemberExpressionParser.self)
    }

    private func parsePostfixSelfExpression() throws -> PostfixSelfExpression {
        return try parse(PostfixSelfExpressionParser.self)
    }

    private func parseSubscriptExpression() throws -> SubscriptExpression {
        return try parse(SubscriptExpressionParser.self)
    }

    private func parseForcedValueExpression() throws -> ForcedValueExpression {
        return try parse(ForcedValueExpressionParser.self)
    }

    private func parseOptionalChainingExpression() throws -> OptionalChainingExpression {
        return try parse(OptionalChainingExpressionParser.self)
    }

    private func parseOperatorPostfixExpression() throws -> OperatorPostfixExpression {
        return try parse(OperatorPostfixExpressionParser.self)
    }
}
