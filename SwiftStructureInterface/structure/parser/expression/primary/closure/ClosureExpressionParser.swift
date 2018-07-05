class ClosureExpressionParser: Parser<ClosureExpression> {

    override func parse() throws -> ClosureExpression {
        let statementParser = getCodeBlockStatementParser()
        return try ClosureExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.leftBrace) }
                .optional { try self.parseClosureSignature() }
                .while { try statementParser.parseCodeBlockStatement() }
                .optional { try self.parsePunctuation(.rightBrace) }
                .build())
    }

    // MARK: - ClosureSignature

    private func parseClosureSignature() throws -> ClosureSignature {
        return try ClosureSignatureImpl(children: builder()
                .optional { try self.parseCaptureList() }
                .optional { try self.parseClosureParameterClause() }
                .optional { try self.parseThrows() }
                .optional { try self.parseFunctionResult() }
                .required { try self.parseKeyword(.in) }
                .build())
    }

    // MARK: - CaptureList

    private func parseCaptureList() throws -> CaptureList {
        return try CaptureListImpl(children: builder()
                .required { try self.parsePunctuation(.leftSquare) }
                .optional { try self.parseCaptureListItems() }
                .optional { try self.parsePunctuation(.rightSquare) }
                .build())
    }

    private func parseCaptureListItems() throws -> CaptureListItems {
        return try CaptureListItemsImpl(children: builder()
                .optional { try self.parseCaptureListItem() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseCaptureListItem()
                }
                .build())
    }

    private func parseCaptureListItem() throws -> CaptureListItem {
        return try CaptureListItemImpl(children: builder()
                .optional { try self.parseDeclarationModifier() }
                .required { try self.parseExpression() }
                .build())
    }

    // MARK: - ClosureParameterClause

    private func parseClosureParameterClause() throws -> ClosureParameterClause {
        if !isNext(.leftParen) {
            return try ClosureParameterClauseImpl(children: builder()
                    .required { try self.parseIdentifierList() }
                    .build())
        }
        return try ClosureParameterClauseImpl(children: builder()
                .required { try self.parsePunctuation(.leftParen) }
                .optional { try self.parseClosureParameterList() }
                .optional { try self.parsePunctuation(.rightParen) }
                .build())
    }

    private func parseClosureParameterList() throws -> ClosureParameterList {
        return try ClosureParameterListImpl(children: builder()
                .required { try self.parseClosureParameter() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseClosureParameter()
                }
                .build())
    }

    private func parseClosureParameter() throws -> ClosureParameter {
        return try ClosureParameterImpl(children: builder()
                .optional { try self.parseIdentifier() }
                .optional { try self.parseTypeAnnotation() }
                .optional { try self.parseVarArgs() }
                .build())
    }
}
