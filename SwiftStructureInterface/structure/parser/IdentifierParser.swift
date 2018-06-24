class IdentifierParser: Parser<Identifier> {

    override func parse(start: LineColumn) -> Identifier {
        if let identifier = peekAtNextIdentifier() {
            advance()
            return IdentifierImpl(text: identifier)
        }
        return IdentifierImpl.emptyIdentifier
    }
}
