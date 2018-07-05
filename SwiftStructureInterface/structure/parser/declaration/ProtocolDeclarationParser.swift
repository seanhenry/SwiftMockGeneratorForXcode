class ProtocolDeclarationParser: BaseDeclarationParser<ProtocolDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> ProtocolDeclaration {
        return try ProtocolDeclarationImpl(children: builder
                .optional { try self.parseDeclarationIdentifier() }
                .optional { try self.parseTypeInheritanceClause() }
                .optional { try self.parseWhereClause() }
                .optional { try self.parseCodeBlock() }
                .build())
    }
}
