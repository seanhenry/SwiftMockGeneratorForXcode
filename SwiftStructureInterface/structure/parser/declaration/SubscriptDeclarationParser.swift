class SubscriptDeclarationParser: DeclarationParser<SubscriptDeclaration> {

    override func parseDeclaration(builder: ParserBuilder) throws -> SubscriptDeclaration {
        return try SubscriptDeclarationImpl(children: builder
                .optional { try self.parseGenericParameterClause() }
                .optional { try self.parseParameterClause() }
                .optional { try self.parseFunctionResult() }
                .optional { try self.parseWhereClause() }
                .optional { try self.parseGetterSetterKeywordBlock() }
                .build())
    }
}
