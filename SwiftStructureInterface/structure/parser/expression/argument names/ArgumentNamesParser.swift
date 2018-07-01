class ArgumentNamesParser: Parser<ArgumentNames> {

    override func parse() throws -> ArgumentNames {
        return try ArgumentNamesImpl(children: builder()
                .required { try self.parseArgumentName() }
                .while { try self.parseArgumentName() }
                .build())
    }

    private func parseArgumentName() throws -> ArgumentName {
        return try ArgumentNameImpl(children: builder()
                .required { try self.parseIdentifier() }
                .required { try self.parsePunctuation(.colon) }
                .build())
    }
}
