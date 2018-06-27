class CodeBlockParser: DeclarationsParser<CodeBlock> {

    override func parse() throws -> CodeBlock {
        return try CodeBlockImpl(children: builder()
                .required { try self.parsePunctuation(.leftBrace) }
                .while { try self.parseDeclaration() }
                .optional { try self.parsePunctuation(.rightBrace) }
                .build())
    }
}
