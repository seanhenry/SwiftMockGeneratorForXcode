class InitializerDeclarationParser: DeclarationParser<InitializerDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> InitializerDeclaration {
        let children = try builder
                .optional { try self.parseOperator("?") }
                .optional { try self.parseOperator("!") }
                .optional { try self.parseGenericParameterClause() }
                .optional { try self.parseParameterClause() }
                .optional { try self.parseThrows() }
                .optional { try self.parseWhereClause() }
                .build()
        return InitializerDeclarationImpl(children: children)
    }
}
