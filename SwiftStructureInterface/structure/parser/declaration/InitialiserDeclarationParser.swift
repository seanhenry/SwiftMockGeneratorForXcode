class InitialiserDeclarationParser: DeclarationParser<InitialiserDeclaration> {

    override func parseDeclaration(start: LineColumn) -> InitialiserDeclaration {
        if isNext("!") {
            advanceOperator("!")
        } else if isNext("?") {
            advanceOperator("?")
        }
        advance(if: .postfixQuestion)
        advance(if: .postfixExclaim)
        _ = parseGenericParameterClause()
        _ = parseFunctionDeclarationParameterClause()
        advance(if: .throws)
        advance(if: .rethrows)
        _ = parseWhereClause()
        return createElement(start: start) { offset, length, text in
            return SwiftInitialiserDeclaration(text: text, children: [], offset: offset, length: length)
        } ?? SwiftInitialiserDeclaration.errorInitialiserDeclaration
    }
}
