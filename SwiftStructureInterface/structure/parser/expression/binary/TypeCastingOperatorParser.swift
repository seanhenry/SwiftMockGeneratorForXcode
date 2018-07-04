class TypeCastingOperatorParser: Parser<TypeCastingOperator> {

    override func parse() throws -> TypeCastingOperator {
        return try TypeCastingOperatorImpl(children: builder()
                .requireEither({ try self.parseKeyword(.as) }) {
                    try self.parseKeyword(.is)
                }
                .either({ try self.parsePunctuation(.postfixQuestion) }) {
                    try self.parsePunctuation(.postfixExclaim)
                }
                .optional { try self.parseType() }
                .build())
    }
}
