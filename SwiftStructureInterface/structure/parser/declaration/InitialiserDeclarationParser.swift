class InitialiserDeclarationParser: DeclarationParser<InitialiserDeclaration> {

    override func parseDeclaration(offset: Int64) -> InitialiserDeclaration {
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
        let length = convert(getPreviousEndLocation())! - offset
        let text = getString(offset: offset, length: length)!
        return SwiftInitialiserDeclaration(text: text, children: [], offset: offset, length: length)
    }
}
