class PunctuationParser: Parser<LeafNode> {

    override func parse() throws -> LeafNode {
        if let punctuation = Punctuation.punctuation[String(describing: peekAtNextKind())] {
            advance()
            return punctuation
        }
        return LeafNodeImpl(text: "")
    }
}
