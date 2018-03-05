class InheritanceClauseParser: Parser<[NamedElement]> {

    override func parse() -> [NamedElement] {
        guard isNext(.colon) else { return [] }
        var types = [NamedElement]()
        repeat {
            advance()
            types.append(parseInheritanceType())
        } while isNext(.comma)
        return types
    }
}
