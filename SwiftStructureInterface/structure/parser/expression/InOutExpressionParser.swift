class InOutExpressionParser: Parser<InOutExpression> {

    override func parse() throws -> InOutExpression {
        return try InOutExpressionImpl(children: builder()
                .required { try self.parseAmp() }
                .required { try self.parseDeclarationIdentifier() }
                .build())
    }

    private func parseAmp() throws -> Element {
        if let amp = try? parsePunctuation(.prefixAmp) {
            return amp
        } else if let amp = try? parseBinaryOperator("&") {
            return amp
        }
        throw LookAheadError()
    }
}
