class TypeInheritanceClauseParser: Parser<[Element]> {

    override func parse(offset: Int64) -> [Element] {
        guard isNext(.colon) else { return [] }
        var types = [Element]()
        repeat {
            advance()
            types.append(parseType())
        } while isNext(.comma)
        return types
    }
}
