class InheritanceClauseParser: Parser<[NamedElement]> {

    override func parse() -> [NamedElement] {
        guard isNext(.colon) else { return [] }
        var types = [NamedElement]()
        repeat {
            advance()
            types.append(parseTypeIdentifier())
        } while isNext(.comma)
        return types
    }
}
