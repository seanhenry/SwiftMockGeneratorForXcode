import Source

class GetterSetterKeywordBlockParser: Parser<GetterSetterKeywordBlock> {

    override func parse() throws -> GetterSetterKeywordBlock {
        return try GetterSetterKeywordBlockImpl(children: builder()
                .required { try self.parsePunctuation(.leftBrace) }
                .optional { try self.parseGetSet() }
                .optional { try self.parseGetSet() }
                .optional { try self.parsePunctuation(.rightBrace) }
                .build())
    }

    private func parseGetSet() throws -> GetterSetterKeywordClause {
        return try GetterSetterKeywordClauseImpl(children: builder()
                .optional { try self.parseAttributes() }
                .optional { try self.parseMutationModifier() }
                .required { try self.parseKeyword([.get, .set]) }
                .build())
    }
}
