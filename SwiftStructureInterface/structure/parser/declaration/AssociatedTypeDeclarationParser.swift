class AssociatedTypeDeclarationParser: BaseDeclarationParser<AssociatedTypeDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> AssociatedTypeDeclaration {
        return try AssociatedTypeDeclarationImpl(children: builder
                .optional { try self.parseDeclarationIdentifier() }
                .optional { try self.parseTypeInheritanceClause() }
                .optional { try self.parseTypealiasAssignment() }
                .optional { try self.parseWhereClause() }
                .build())
    }
}
