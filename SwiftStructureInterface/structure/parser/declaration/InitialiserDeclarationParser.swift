class InitialiserDeclarationParser: DeclarationParser<InitialiserDeclaration> {

    override func parseDeclaration(start: LineColumn, accessLevelModifier: AccessLevelModifier) -> InitialiserDeclaration {
        let isFailable = parseIsFailable()
        _ = parseGenericParameterClause()
        let parameters = parseFunctionDeclarationParameterClause()
        let `throws` = parseThrows()
        let `rethrows` = parseRethrows()
        advance(if: .throws)
        advance(if: .rethrows)
        _ = parseWhereClause()
        return createElement(start: start) { offset, length, text in
            return InitialiserDeclarationImpl(
                text: text,
                children: parameters,
                offset: offset,
                length: length,
                parameters: parameters,
                throws: `throws`,
                rethrows: `rethrows`,
                isFailable: isFailable)
        } ?? InitialiserDeclarationImpl.errorInitialiserDeclaration
    }

    private func parseIsFailable() -> Bool {
        var isFailable = false
        if isNext("?") {
            advanceOperator("?")
            isFailable = true
        } else if isNext("!") {
            advanceOperator("!")
            isFailable = true
        }
        return isFailable
    }

    private func parseThrows() -> Bool {
        if isNext(.throws) {
            advance()
            return true
        }
        return false
    }

    private func parseRethrows() -> Bool {
        if isNext(.rethrows) {
            advance()
            return true
        }
        return false
    }
}
