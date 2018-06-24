class PunctuationParser: Parser<LeafNode> {

    override func parse(start: LineColumn) -> LeafNode {
        if let puncuation = Punctuation.punctuation[String(describing: peekAtNextKind())] {
            advance()
            return puncuation
        }
        return LeafNodeImpl(text: "")
    }
}
