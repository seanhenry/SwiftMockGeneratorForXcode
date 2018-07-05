class ParameterParser: Parser<Parameter> {

    override func parse() throws -> Parameter {
        if isNext(.eof) {
            throw LookAheadError()
        }
        return try ParameterImpl(children: builder()
                .optional { try self.parsePunctuation(.underscore) }
                .optional { try self.parseParameterIdentifier() }
                .optional { try self.parseParameterIdentifier() }
                .optional { try self.parseTypeAnnotation() }
                .either({ try self.parseVarArgs() }) {
                    try self.parseDefaultArgumentClause()
                }
                .build())
    }
}
