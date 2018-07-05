class ExplicitMemberExpressionParser: CompoundPostfixExpressionParser<ExplicitMemberExpression> {

    override func parse() throws -> ExplicitMemberExpression {
        if isIdentifierExplicitMember() {
            return try parseIdentifierExplicitMember()
        } else {
            return try ExplicitMemberExpressionImpl(children:builder()
                    .required { self.postfixExpression }
                    .required { try self.parsePunctuation(.dot) }
                    .required { try self.parseDecimalDigits() }
                    .build())
        }
    }

    private func isIdentifierExplicitMember() -> Bool {
        return isDeclarationIdentifier(peekAtKind(aheadBy: 1))
    }

    private func parseIdentifierExplicitMember() throws -> ExplicitMemberExpression {
        if let expression = try? parseWithGenericArgumentClause() {
            return expression
        } else if let expression = try? parseWithArgumentNames() {
            return expression
        } else if let expression = try? parseSimpleExplicitMember() {
            return expression
        } else {
            throw LookAheadError()
        }
    }

    private func parseSimpleExplicitMember() throws -> ExplicitMemberExpression {
        return try ExplicitMemberExpressionImpl(children: builder()
                .required { self.postfixExpression }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseDeclarationIdentifier() }
                .build())
    }

    private func parseWithGenericArgumentClause() throws -> ExplicitMemberExpression {
        return try ExplicitMemberExpressionImpl(children: builder()
                .required { self.postfixExpression }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseDeclarationIdentifier() }
                .required { try self.parseGenericArgumentClause() }
                .build())
    }

    private func parseWithArgumentNames() throws -> ExplicitMemberExpression {
        return try ExplicitMemberExpressionImpl(children: builder()
                .required { self.postfixExpression }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseDeclarationIdentifier() }
                .required { try self.parsePunctuation(.leftParen) }
                .optional { try self.parseArgumentNames() }
                .required { try self.parsePunctuation(.rightParen) }
                .build())
    }

    private func parseDecimalDigits() throws -> Element {
        if case let .integerLiteral(_, rawRepresentation: rawInt) = peekAtNextKind() {
            advance()
            return LeafNodeImpl(text: rawInt)
        }
        throw LookAheadError()
    }
}
