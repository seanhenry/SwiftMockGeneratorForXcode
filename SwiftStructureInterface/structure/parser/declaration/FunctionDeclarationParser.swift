class FunctionDeclarationParser: DeclarationParser<FunctionDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> FunctionDeclaration {
        return try FunctionDeclarationImpl(children:builder
                .optional { try self.parseIdentifier() }
                .optional { try self.parseGenericParameterClause() }
                .optional { try self.parseParameterClause() }
                .optional { try self.parseThrows() }
                .optional { try self.parseFunctionResult() }
                .optional { try self.parseWhereClause() }
                .build())
    }
}
