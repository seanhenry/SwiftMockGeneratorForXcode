class TypeIdentifierParser: Parser<NamedElement> {

    private class Error: Swift.Error {}

    override func parse() -> NamedElement {
        let start = getCurrentStartLocation()
        if let identifier = parseType() {
            let offset = convert(start)!
            let length = convert(getPreviousEndLocation())! - offset
            return SwiftInheritedType(name: identifier,
                text: identifier,
                children: [],
                offset: offset,
                length: length)
        }
        return SwiftInheritedType.error
    }

    private func parseType() -> String? {
        guard let identifier = peekAtNextIdentifier() else { return nil }
        advance()
        return identifier + parseSubTypes() + parseGenericClause()
    }

    // MARK: - Nested

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

    // MARK: - Generic

    private func parseGenericClause() -> String {
        var clause = ""
        do {
            try appendGenericClauseStart(to: &clause)
            appendGenericArgument(to: &clause)
            appendGenericArgumentList(to: &clause)
            try appendGenericClauseEnd(to: &clause)
        } catch {} // ignored
        return clause
    }

    private func appendGenericClauseStart(to string: inout String) throws {
        if isGenericClauseStart() {
            advance()
            string.append("<")
        } else {
            throw Error()
        }
    }

    private func appendGenericArgument(to string: inout String) {
        string.append(parseType() ?? "")
    }

    private func appendGenericArgumentList(to string: inout String) {
        while isNext(.comma) {
            advance()
            string.append(", ")
            appendGenericArgument(to: &string)
        }
    }

    private func appendGenericClauseEnd(to string: inout String) throws {
        if isGenericClauseEnd() {
            string.append(isDoubleGenericClauseEnd() ? ">>" : ">")
            advance()
        } else {
            throw Error()
        }
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
