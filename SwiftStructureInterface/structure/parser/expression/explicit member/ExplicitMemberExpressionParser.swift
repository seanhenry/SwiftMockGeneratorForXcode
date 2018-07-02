class ExplicitMemberExpressionParser: Parser<ExplicitMemberExpression> {

    override func parse() throws -> ExplicitMemberExpression {
        return try ExplicitMemberExpressionImpl(children: builder()
                .required { try self.parsePostfixExpression() }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseExplicitMember() }
                .optional { try self.parsePunctuation(.leftParen) }
                .either({ try self.parseGenericArgumentClause() }) {
                    try self.parseArgumentNames()
                }
                .optional { try self.parsePunctuation(.rightParen) }
                .build())
    }

    private func parseExplicitMember() throws -> Element {
        if let int = try? parseDecimalDigits() {
            return int
        } else if let identifier = try? parseIdentifier() {
            return identifier
        }
        throw LookAheadError()
    }
    
    private func parseDecimalDigits() throws -> Element {
        if case let .integerLiteral(_, rawRepresentation: rawInt) = peekAtNextKind() {
            return LeafNodeImpl(text: rawInt)
        }
        throw LookAheadError()
    }
}
