class DeclarationIdentifierParser: Parser<Identifier> {

    override func parse() throws -> Identifier {
        if let identifier = try? parseStrictIdentifier() {
            return identifier
        }
        let key = String(describing: peekAtNextKind())
        if let identifier = Keywords.identifiers[key] {
            advance()
            return IdentifierImpl(text: identifier)
        }
        throw LookAheadError()
    }
}
