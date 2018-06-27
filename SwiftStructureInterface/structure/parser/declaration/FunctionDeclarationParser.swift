import Source

class FunctionDeclarationParser: DeclarationParser<FunctionDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> FunctionDeclaration {
        return try FunctionDeclarationImpl(children:builder
                .optional { try self.parseIdentifier() }
                .optional { try self.parseGenericParameterClause() }
                .optional { try self.parseParameterClause() }
                .optional { try self.parseThrows() }
                .optional { try self.parseFunctionDeclarationResult() }
                .optional { try self.parseWhereClause() }
                .build())
    }

    class ResultParser: Parser<FunctionResult> {

        override func parse() throws -> FunctionResult {
            return try FunctionResultImpl(children: builder()
                    .required { try self.parsePunctuation(.arrow) }
                    .optional { try self.parseAttributes() }
                    .optional { try self.parseType() }
                    .build())
        }
    }
}
