class AssociatedTypeDeclarationParser: DeclarationParser<Element> {
    override func parseDeclaration(builder: ParserBuilder) throws -> Element {
        return try ElementImpl(children: builder
                .optional { try self.parseIdentifier() }
                .optional { try self.parseTypeInheritanceClause() }
                .optional { try self.parseTypealiasAssignment() }
                .optional { try self.parseWhereClause() }
                .build())
    }
}
