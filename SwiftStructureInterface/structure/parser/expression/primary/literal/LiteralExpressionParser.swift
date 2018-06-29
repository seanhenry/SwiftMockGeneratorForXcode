class LiteralExpressionParser: Parser<LiteralExpression> {

    override func parse() throws -> LiteralExpression {
        if isNext(.hash) {
            return try parseHashLiteral()
        } else if isNext(.leftSquare) {
            return try parseArrayDictionaryLiteral()
        } else if case let .integerLiteral(_, rawRepresentation: rawInt) = peekAtNextKind() {
            return try createLiteralExpression(rawInt)
        } else if case let .floatingPointLiteral(_, rawRepresentation: rawFloat) = peekAtNextKind() {
            return try createLiteralExpression(rawFloat)
        } else if case let .booleanLiteral(bool) = peekAtNextKind() {
            return try createLiteralExpression("\(bool)")
        } else if case let .staticStringLiteral(_, rawRepresentation: rawString) = peekAtNextKind() {
            return try createLiteralExpression(rawString)
        } else if case let .interpolatedStringLiteralHead(_, rawRepresentation: rawString) = peekAtNextKind() {
            return try parseInterpolatedStringExpression(rawString)
        } else if isNext(.nil) {
            return try createLiteralExpression("nil")
        } else {
            throw LookAheadError()
        }
    }

    private func createLiteralExpression(_ rawValue: String) throws -> LiteralExpression {
        advance()
        return try LiteralExpressionImpl(children: builder()
                .required { LeafNodeImpl(text: rawValue) }
                .build())
    }

    private func parseHashLiteral() throws -> LiteralExpression {
        if let expression = try? parseKeywordLiteral() {
            return expression
        } else if let expression = try? parsePlaygroundLiteral() {
            return expression
        }
        throw LookAheadError()
    }

    private func parseArrayDictionaryLiteral() throws -> LiteralExpression {
        if let expression = try? parseDictionaryLiteral() {
            return expression
        } else if let expression = try? parseArrayLiteral() {
            return expression
        }
        throw LookAheadError()
    }

    // MARK: - Keyword

    private func parseKeywordLiteral() throws -> LiteralExpression {
        return try KeywordLiteralExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.hash) }
                .required { try self.parseIdentifier(["file", "line", "column", "function"]) }
                .build())
    }

    // MARK: - Playground

    private func parsePlaygroundLiteral() throws -> LiteralExpression {
        return try PlaygroundLiteralExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.hash) }
                .required { try self.parseIdentifier(["fileLiteral", "imageLiteral", "colorLiteral"]) }
                .optional { try self.parsePunctuation(.leftParen) }
                .optional { try self.parsePlaygroundArguments() }
                .optional { try self.parsePunctuation(.rightParen) }
                .build())
    }

    private func parsePlaygroundArguments() throws -> PlaygroundLiteralArguments {
        return try PlaygroundLiteralArgumentsImpl(children: builder()
                .optional { try self.parsePlaygroundArgument() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parsePlaygroundArgument()
                }
                .build())
    }

    private func parsePlaygroundArgument() throws -> PlaygroundLiteralArgument {
        return try PlaygroundLiteralArgumentImpl(children: builder()
                .optional { try self.parseIdentifier() }
                .optional { try self.parsePunctuation(.colon) }
                .optional { try self.parseExpression() }
                .build())
    }

    // MARK: - Array

    private func parseArrayLiteral() throws -> ArrayLiteralExpression {
        return try ArrayLiteralExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.leftSquare) }
                .optional { try self.parseArrayLiteralItems() }
                .optional { try self.parsePunctuation(.rightSquare) }
                .build())
    }

    private func parseArrayLiteralItems() throws -> ArrayLiteralItems {
        return try ArrayLiteralItemsImpl(children: builder()
                .optional { try self.parseArrayLiteralItem() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseArrayLiteralItem()
                }
                .build())
    }

    private func parseArrayLiteralItem() throws -> ArrayLiteralItem {
        return try ArrayLiteralItemImpl(children: builder()
                .required { try self.parseExpression() }
                .build())
    }

    // MARK: - Dictionary

    private func parseDictionaryLiteral() throws -> DictionaryLiteralExpression {
        return try DictionaryLiteralExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.leftSquare) }
                .required { try self.parseDictionaryLiteralItems() }
                .optional { try self.parsePunctuation(.rightSquare) }
                .build())
    }

    private func parseDictionaryLiteralItems() throws -> DictionaryLiteralItems {
        return try DictionaryLiteralItemsImpl(children: builder()
                .required { try self.parseDictionaryLiteralItem() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseDictionaryLiteralItem()
                }
                .build())
    }

    private func parseDictionaryLiteralItem() throws -> DictionaryLiteralItem {
        return try DictionaryLiteralItemImpl(children: builder()
                .optional { try self.parseExpression() }
                .required { try self.parsePunctuation(.colon) }
                .optional { try self.parseExpression() }
                .build())
    }

    // MARK: - Interpolated string

    private func parseInterpolatedStringExpression(_ head: String) throws -> LiteralExpression {
        throw LookAheadError()
//        advance()
//        return try LiteralExpressionImpl(children: builder()
//                .required { LeafNodeImpl(text: head) }
//                .optional { try self.parseExpression() }
//                .optional { try self.parsePunctuation(.rightParen) }
//                .build())
    }
}
