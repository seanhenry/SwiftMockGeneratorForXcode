class IdentifierListParser: Parser<IdentifierList> {

    override func parse() throws -> IdentifierList {
        return try IdentifierListImpl(children: builder()
                .required { try self.parseDeclarationIdentifier() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseDeclarationIdentifier()
                }
                .build())
    }
}
