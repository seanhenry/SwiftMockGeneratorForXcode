class ProtocolDeclarationParser: DeclarationParser<TypeDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> TypeDeclaration {
        return try TypeDeclarationImpl(children: builder
                .optional { try self.parseIdentifier() }
                .optional { try self.parseTypeInheritanceClause() }
                .optional { try self.parseWhereClause() }
                .optional { try self.parseTypeCodeBlock() }
                .build())
    }
}
