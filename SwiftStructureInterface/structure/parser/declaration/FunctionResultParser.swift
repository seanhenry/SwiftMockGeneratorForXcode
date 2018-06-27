class FunctionResultParser: Parser<FunctionResult> {

    override func parse() throws -> FunctionResult {
        return try FunctionResultImpl(children: builder()
                .required { try self.parsePunctuation(.arrow) }
                .optional { try self.parseAttributes() }
                .optional { try self.parseType() }
                .build())
    }
}
