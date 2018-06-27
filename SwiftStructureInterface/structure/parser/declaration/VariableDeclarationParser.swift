class VariableDeclarationParser: DeclarationParser<VariableDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> VariableDeclaration {
        return try VariableDeclarationImpl(children: builder
                .optional { try self.parseIdentifier() }
                .optional { try self.parseTypeAnnotation() }
                .optional { try self.parseGetterSetterKeywordBlock() }
                .build())
    }
}
