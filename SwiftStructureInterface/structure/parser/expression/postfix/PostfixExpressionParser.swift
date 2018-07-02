class PostfixExpressionParser: Parser<PostfixExpression> {

    override func parse() throws -> PostfixExpression {
        if let primaryExpression = try? parsePrimaryExpression() {
            return (try? parsePostfixExpression(primaryExpression))
                    ?? primaryExpression
        }
        throw LookAheadError()
    }

    private func parsePostfixExpression(_ postfixExpression: PostfixExpression) throws -> PostfixExpression {
        if let expression = try? parseFunctionCallExpression(postfixExpression) {
            return expression
        } else if let expression = try? parseInitializerExpression(postfixExpression) {
            return expression
        } else if let expression = try? parseExplicitMemberExpression(postfixExpression) {
            return expression
        } else if let expression = try? parsePostfixSelfExpression(postfixExpression) {
            return expression
        } else if let expression = try? parseSubscriptExpression(postfixExpression) {
            return expression
        } else if let expression = try? parseForcedValueExpression(postfixExpression) {
            return expression
        } else if let expression = try? parseOptionalChainingExpression(postfixExpression) {
            return expression
        } else if let expression = try? parseOperatorPostfixExpression(postfixExpression) {
            return expression
        }
        throw LookAheadError()
    }

    private func parseFunctionCallExpression(_ postfixExpression: PostfixExpression) throws -> FunctionCallExpression {
        return try parseCompoundPostfixExpression(FunctionCallExpressionParser.self, postfixExpression)
    }

    private func parseInitializerExpression(_ postfixExpression: PostfixExpression) throws -> InitializerExpression {
        return try parseCompoundPostfixExpression(InitializerExpressionParser.self, postfixExpression)
    }

    private func parseExplicitMemberExpression(_ postfixExpression: PostfixExpression) throws -> ExplicitMemberExpression {
        return try parseCompoundPostfixExpression(ExplicitMemberExpressionParser.self, postfixExpression)
    }

    private func parsePostfixSelfExpression(_ postfixExpression: PostfixExpression) throws -> PostfixSelfExpression {
        return try parseCompoundPostfixExpression(PostfixSelfExpressionParser.self, postfixExpression)
    }

    private func parseSubscriptExpression(_ postfixExpression: PostfixExpression) throws -> SubscriptExpression {
        return try parseCompoundPostfixExpression(SubscriptExpressionParser.self, postfixExpression)
    }

    private func parseForcedValueExpression(_ postfixExpression: PostfixExpression) throws -> ForcedValueExpression {
        return try parseCompoundPostfixExpression(ForcedValueExpressionParser.self, postfixExpression)
    }

    private func parseOptionalChainingExpression(_ postfixExpression: PostfixExpression) throws -> OptionalChainingExpression {
        return try parseCompoundPostfixExpression(OptionalChainingExpressionParser.self, postfixExpression)
    }

    private func parseOperatorPostfixExpression(_ postfixExpression: PostfixExpression) throws -> OperatorPostfixExpression {
        return try parseCompoundPostfixExpression(OperatorPostfixExpressionParser.self, postfixExpression)
    }
}
