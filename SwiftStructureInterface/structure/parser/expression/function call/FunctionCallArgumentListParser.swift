class FunctionCallArgumentListParser: Parser<FunctionCallArgumentList> {

    override func parse() throws -> FunctionCallArgumentList {
        return try FunctionCallArgumentListImpl(children: builder()
                .required { try self.parseFunctionCallArgument() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseFunctionCallArgument()
                }
                .build())
    }

    private func parseFunctionCallArgument() throws -> FunctionCallArgument {
        if peekAtKind(aheadBy: 1) == .colon {
            return try FunctionCallArgumentImpl(children: builder()
                    .required { try self.parseParameterIdentifier() }
                    .required { try self.parsePunctuation(.colon) }
                    .required { try self.parseExpressionOrOperator() }
                    .build())
        } else {
            return try FunctionCallArgumentImpl(children: builder()
                    .required { try self.parseExpressionOrOperator() }
                    .build())
        }
    }

    private func parseExpressionOrOperator() throws -> Element {
        if let op = try? self.parseOperator() {
            return op
        } else if let expression = try? parseExpression() {
            return expression
        }
        throw LookAheadError()
    }
}
