class TypeInheritanceClauseParser: Parser<TypeInheritanceClause> {

    override func parse() throws -> TypeInheritanceClause {
        return try TypeInheritanceClauseImpl(children: builder()
                .required { try self.parsePunctuation(.colon) }
                .optional { try self.parseInheritanceType() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseInheritanceType()
                }
                .build())
    }

    private func parseInheritanceType() throws -> Element {
        if let type = try? parseType() {
            return type
        } else if let type = try? parseKeyword(.class) {
            return TypeIdentifierImpl(children: [type])
        }
        throw LookAheadError()
    }
}
