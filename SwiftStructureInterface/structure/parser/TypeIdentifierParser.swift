class TypeIdentifierParser: Parser<NamedElement> {

    override func parse() -> NamedElement {
        let start = getCurrentStartLocation()
        if var identifier = peekAtNextIdentifier() {
            advance()
            identifier += parseSubTypes()
            return SwiftInheritedType(name: identifier,
                text: identifier,
                children: [],
                offset: convert(start)!,
                length: getLength(identifier))
        }
        return SwiftInheritedType.error
    }

    private func parseSubTypes() -> String {
        var identifier = ""
        while isNext(.dot) {
            advance()
            identifier += "."
            if let nextID = peekAtNextIdentifier() {
                advance()
                identifier += nextID
            }
        }
        return identifier
    }
}
