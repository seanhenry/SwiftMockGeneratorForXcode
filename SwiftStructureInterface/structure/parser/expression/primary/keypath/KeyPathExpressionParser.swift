class KeyPathExpressionParser: Parser<KeyPathExpression> {

    override func parse() throws -> KeyPathExpression {
        return try KeyPathExpressionImpl(children: builder()
                .required { try self.parsePunctuation(.backslash) }
                .optional { try self.parseDeclarationIdentifier() }
                .required { try self.parsePunctuation(.dot) }
                .required { try self.parseComponents() }
                .build())
    }

    private func parseComponents() throws -> KeyPathComponents {
        return try KeyPathComponentsImpl(children: builder()
                .required { try self.parseComponent() }
                .while(isParsed: { try self.parsePunctuation(.dot) }) {
                    try self.parseComponent()
                }
                .build())
    }

    private func parseComponent() throws -> KeyPathComponent {
        return try KeyPathComponentImpl(children: builder()
                .optional { try self.parseDeclarationIdentifier() }
                .optional { try self.parsePostfixes() }
                .build())
    }

    private func parsePostfixes() throws -> KeyPathPostfixes {
        return try KeyPathPostfixesImpl(children: builder()
                .while { try self.parsePostfix() }
                .build())
    }

    private func parsePostfix() throws -> KeyPathPostfix {
        if isNext(.leftSquare) {
            return try parsePostfixFunctionCallArgumentList()
        }
        return try KeyPathPostfixImpl(children: builder()
                .required { try self.parseAnyPostfixItem() }
                .build())
    }

    private func parseAnyPostfixItem() throws -> Element {
        if let postfix = try? parseOperator("?") {
            return postfix
        } else if let postfix = try? parseOperator("!") {
            return postfix
        }
        throw LookAheadError()
    }

    private func parsePostfixFunctionCallArgumentList() throws -> KeyPathPostfix {
        return try KeyPathPostfixImpl(children: builder()
                .required { try self.parsePunctuation(.leftSquare) }
                .optional { try self.parseFunctionCallArgumentList() }
                .optional { try self.parsePunctuation(.rightSquare) }
                .build())
    }
}
