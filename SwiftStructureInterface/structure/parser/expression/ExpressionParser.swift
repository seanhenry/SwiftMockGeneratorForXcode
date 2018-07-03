class ExpressionParser: Parser<Expression> {

    override func parse() throws -> Expression {
        return try ExpressionImpl(children: builder()
                .optional { try self.parseKeyword(.try) }
                .optional { try self.parsePrefixOperator() }
                .required { try self.parsePrefixExpression() }
                .build())
    }

    private func parsePrefixExpression() throws -> Expression {
        if let expression = try? parsePostfixExpression() {
            return expression
        } else if let expression = try? parseInOutExpression() {
            return expression
        }
        throw LookAheadError()
    }
}
