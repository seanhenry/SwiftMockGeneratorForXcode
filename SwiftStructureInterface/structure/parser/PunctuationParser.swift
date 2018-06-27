class PunctuationParser: Parser<LeafNode> {

    override func parse() throws -> LeafNode {
        if let punctuation = Punctuation.punctuation[String(describing: peekAtNextKind())] {
            advance()
            return LeafNodeImpl(text: punctuation)
        }
        return LeafNodeImpl(text: "")
    }
}
