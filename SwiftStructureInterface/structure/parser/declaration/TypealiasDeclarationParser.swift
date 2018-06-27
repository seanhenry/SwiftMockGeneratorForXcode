class TypealiasDeclarationParser: DeclarationParser<TypealiasDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> TypealiasDeclaration {
        return try TypealiasDeclarationImpl(children: builder
                .optional { try self.parseIdentifier() }
                .optional { try self.parseGenericParameterClause() }
                .optional { try self.parseTypealiasAssignment() }
                .build())
    }
}
