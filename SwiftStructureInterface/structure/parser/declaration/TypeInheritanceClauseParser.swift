class TypeInheritanceClauseParser: Parser<[Element]> {

    override func parse(start: LineColumn) -> [Element] {
        guard isNext(.colon) else { return [] }
        var types = [Element]()
        repeat {
            advance()
            types.append(parseType())
        } while isNext(.comma)
        return types
    }
}
