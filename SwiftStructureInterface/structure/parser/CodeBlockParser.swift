class CodeBlockParser: Parser<CodeBlock> {

    override func parse() throws -> CodeBlock {
        let statementParser = getCodeBlockStatementParser()
        return try CodeBlockImpl(children: builder()
                .required { try self.parsePunctuation(.leftBrace) }
                .while { try statementParser.parse() }
                .optional { try self.parsePunctuation(.rightBrace) }
                .build())
    }
}
