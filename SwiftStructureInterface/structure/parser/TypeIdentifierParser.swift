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
        if var type = parseProtocolCompositionType() ?? parseTypeIdentifier() ?? parseArrayType() ?? parseDictionaryType() {
            appendOptional(to: &type)
            return type
        }
        return nil
    }

    private func parseTypeIdentifier() -> String? {
        guard let typeName = parseTypeName() else { return nil }
        return typeName + parseGenericClause()
    }

    private func parseTypeName() -> String? {
        return parseIdentifier()
    }

    private func parseIdentifier() -> String? {
        if let implicit = parseImplicitParameterName() {
            return implicit
        } else if let identifier = peekAtNextIdentifier() {
            advance()
            return identifier + parseNestedTypes()
        }
        return nil
    }

    // MARK: - Implicit

    private func parseImplicitParameterName() -> String? {
        if let implicitName = peekAtNextImplicitParameterName() {
            advance()
            return implicitName
        }
        return nil
    }

    // MARK: - Nested

    private func parseNestedTypes() -> String {
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
            clause.append(parseNestedTypes())
            clause.append(parseGenericClause())
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
            if isOptionalGenericClauseEnd() {
                string.append(">?")
            } else if isDoubleGenericClauseEnd() {
                string.append(">>")
            } else if isIUOGenericClauseEnd() {
                string.append(">!")
            } else {
                string.append(">")
            }
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
        return isPostfixOperator(">>")
    }

    private func isOptionalGenericClauseEnd() -> Bool {
        // a '>?' postfix operator is detected for optional generics (Generic<Type>?)
        return isPostfixOperator(">?")
    }

    private func isIUOGenericClauseEnd() -> Bool {
        // a '>!' postfix operator is detected for IUO generics (Generic<Type>!)
        return isPostfixOperator(">!")
    }

    // MARK: - Array

    private func parseArrayType() -> String? {
        return tryToParse {
            var array = ""
            try append(.leftSquare, value: "[", to: &array)
            appendType(to: &array)
            try append(.rightSquare, value: "]", to: &array)
            return array
        }
    }

    // MARK: - Dictionary

    private func parseDictionaryType() -> String? {
        return tryToParse {
            var dictionary = ""
            try append(.leftSquare, value: "[", to: &dictionary)
            appendType(to: &dictionary)
            try append(.colon, value: ":", to: &dictionary)
            appendType(to: &dictionary)
            try append(.rightSquare, value: "]", to: &dictionary)
            return dictionary
        }
    }

    // MARK: - Optional

    private func appendOptional(to string: inout String) {
        if isNext(.postfixQuestion) {
            advance()
            string.append("?")
        } else if isNext(.postfixExclaim) {
            advance()
            string.append("!")
        } else if isPostfixOperator("??") {
            advance()
            string.append("??")
        } else if isPostfixOperator("!!") {
            advance()
            string.append("!!")
        }
    }

    // MARK: - Protocol composition

    func parseProtocolCompositionType() -> String? {
        return tryToParse {
            var composition = ""
            try appendTypeIdentifier(to: &composition)
            try appendCompositionRHS(to: &composition)
            repeat {
                try? appendCompositionRHS(to: &composition)
            } while isNextAmpBinaryOperator()
            return composition
        }
    }

    private func appendTypeIdentifier(to string: inout String) throws {
        if let type = parseTypeIdentifier() {
            string.append(type)
        } else {
            throw Error()
        }
    }

    private func appendCompositionRHS(to string: inout String) throws {
        try appendAmpBinaryOperator(to: &string)
        try appendTypeIdentifier(to: &string)
    }

    private func appendAmpBinaryOperator(to string: inout String) throws {
        try appendBinaryOperator("&", value: " & ", to: &string)
    }

    private func isNextAmpBinaryOperator() -> Bool {
        return isBinaryOperator("&")
    }
}
