class TypeIdentifierParser: Parser<NamedElement> {

    override func parse() -> NamedElement {
        let start = getCurrentStartLocation()
        if let identifier = parseType() {
            return SwiftInheritedType(name: identifier,
                text: identifier,
                children: [],
                offset: convert(start)!,
                length: getLength(identifier))
        }
        return SwiftInheritedType.error
    }

    private func parseType() -> String? {
        guard let identifier = peekAtNextIdentifier() else { return nil }
        advance()
        return identifier + parseSubTypes() + parseGenericClause()
    }

    private func parseSubTypes() -> String {
        var identifier = ""
        while isNext(.dot) {
            advance()
            identifier.append(".")
            appendIdentifier(to: &identifier)
        }
        return identifier
    }

    private func appendIdentifier(to string: inout String) {
        if let nextID = peekAtNextIdentifier() {
            advance()
            string.append(nextID)
        }
    }

    private func parseGenericClause() -> String {
        var clause = ""
        if isGenericClauseStart() {
            advance()
            clause.append("<")
            clause.append(parseType() ?? "")
            if isGenericClauseEnd() {
                clause.append(isDoubleGenericClauseEnd() ? ">>" : ">")
                advance()
            }
        }
        return clause
    }

    private func isGenericClauseStart() -> Bool {
        return isNext("<")
    }

    private func isGenericClauseEnd() -> Bool {
        return isNext(">")
    }

    private func isDoubleGenericClauseEnd() -> Bool {
        // a '>>' postfix operator is detected when generics are nested (Generic<Type<InnerType>>)
        if case let .postfixOperator(op) = peekAtNextKind() {
            return op == ">>"
        }
        return false
    }
}
