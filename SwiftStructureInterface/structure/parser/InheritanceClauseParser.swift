class InheritanceClauseParser: Parser<[NamedElement]> {

    override func parse() -> [NamedElement]? {
        guard isNext(.colon) else { return [] }
        var types = [NamedElement]()
        repeat {
            advance()
            parseInheritanceType().map { types.append($0) }
        } while isNext(.comma)
        return types
    }
}
