import Lexer

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
        if let type = parsePlainType() ?? parseArrayType() {
            return type + parseGenericClause()
        }
        return nil
    }

    private func parsePlainType() -> String? {
        guard let identifier = peekAtNextIdentifier() else { return nil }
        advance()
        return identifier + parseSubTypes()
    }

    // MARK: - Nested

    private func parseSubTypes() -> String {
        var identifier = ""
        while isNext(.dot) {
            advance()
            identifier.append(".")
            tryToAppendIdentifier(to: &identifier)
        }
        return identifier
    }

    // MARK: - Generic

    private func parseGenericClause() -> String {
        var clause = ""
        do {
            try appendGenericClauseStart(to: &clause)
            appendType(to: &clause)
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

    private func appendType(to string: inout String) {
        string.append(parseType() ?? "")
    }

    private func appendGenericArgumentList(to string: inout String) {
        while isNext(.comma) {
            advance()
            string.append(", ")
            appendType(to: &string)
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

    // MARK: - Array

    private func parseArrayType() -> String? {
        do {
            var array = ""
            try append(.leftSquare, value: "[", to: &array)
            appendType(to: &array)
            try append(.rightSquare, value: "]", to: &array)
            return array
        } catch {} // ignored
        return nil
    }
}
