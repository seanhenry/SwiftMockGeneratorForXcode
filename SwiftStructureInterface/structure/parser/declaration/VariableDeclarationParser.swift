class VariableDeclarationParser: BaseDeclarationParser<VariableDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> VariableDeclaration {
        return try VariableDeclarationImpl(children: builder
                .optional { try self.parseDeclarationIdentifier() }
                .optional { try self.parseTypeAnnotation() }
                .either({ try self.parseGetterSetterKeywordBlock() }) {
                    try self.parseCodeBlock()
                }
                .build())
    }
}
