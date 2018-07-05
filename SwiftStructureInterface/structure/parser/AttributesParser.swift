class AttributesParser: Parser<Attributes> {

    override func parse() throws -> Attributes {
        return try AttributesImpl(children: builder()
                .required { try self.parseAttribute() }
                .while { try self.parseAttribute() }
                .build())
    }

    private func parseAttribute() throws -> Attribute {
        let children = try builder()
                .required { try self.parsePunctuation(.at) }
                .optional { try self.parseStrictIdentifier() }
                .build()

        return AttributeImpl(children: children + parseArguments())
    }

    private func parseArguments() -> [Element] {
        return tryToParse {
            let args: [Element] = [
                try parsePunctuation(.leftParen),
                try parseStrictIdentifier(),
                try parsePunctuation(.rightParen)
            ]
            if isNext([.arrow, .comma, .rightParen]) {
                throw LookAheadError()
            }
            return args
        } ?? []
    }
}
