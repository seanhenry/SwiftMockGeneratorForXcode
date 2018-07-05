class StrictIdentifierParser: Parser<Identifier> {

    override func parse() throws -> Identifier {
        if let identifier = peekAtNextIdentifier() {
            advance()
            return IdentifierImpl(text: identifier)
        } else if isNext(.underscore) {
            advance()
            return IdentifierImpl(text: Punctuation.underscore)
        }
        throw LookAheadError()
    }
}
