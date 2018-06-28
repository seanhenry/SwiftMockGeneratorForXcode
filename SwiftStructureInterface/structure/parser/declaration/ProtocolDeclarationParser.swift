class ProtocolDeclarationParser: DeclarationParser<ProtocolDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> ProtocolDeclaration {
        return try ProtocolDeclarationImpl(children: builder
                .optional { try self.parseIdentifier() }
                .optional { try self.parseTypeInheritanceClause() }
                .optional { try self.parseWhereClause() }
                .optional { try self.parseTypeCodeBlock() }
                .build())
    }
}
