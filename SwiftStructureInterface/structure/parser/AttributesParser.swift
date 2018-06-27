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
                .optional { try self.parseIdentifier() }
                .build()
        return AttributeImpl(children: children + parseArguments())
    }

    private func parseArguments() -> [Element] {
        return tryToParse {
            let args: [Element] = [
                try parsePunctuation(.leftParen),
                try parseIdentifier(),
                try parsePunctuation(.rightParen)
            ]
            return args
        } ?? []
    }
}
