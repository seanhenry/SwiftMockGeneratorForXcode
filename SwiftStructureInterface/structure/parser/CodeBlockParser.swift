class CodeBlockParser: Parser<CodeBlock> {

    override func parse() throws -> CodeBlock {
        var children = [Element]()
        (try? parsePunctuation(.leftBrace)).flatMap { children.append($0) }
        (try? parseDeclarations()).flatMap { children.append(contentsOf: $0) }
        (try? parsePunctuation(.rightBrace)).flatMap { children.append($0) }
        return CodeBlockImpl(children: children)
    }
}
