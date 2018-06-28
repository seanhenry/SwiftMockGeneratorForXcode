class ClassDeclarationParser: Parser<ClassDeclaration> {

    override func parse() throws -> ClassDeclaration {
        return try ClassDeclarationImpl(children: builder()
                .optional { try self.parseAttributes() }
                .while { try self.parseModifierExceptClass() }
                .required { try self.parseKeyword(.class) }
                .optional { try self.parseIdentifier() }
                .optional { try self.parseGenericParameterClause() }
                .optional { try self.parseTypeInheritanceClause() }
                .optional { try self.parseWhereClause() }
                .optional { try self.parseTypeCodeBlock() }
                .build())
    }

    private func parseModifierExceptClass() throws -> DeclarationModifier {
        if isNext(.class) {
            throw LookAheadError()
        }
        return try parseDeclarationModifier()
    }
}
