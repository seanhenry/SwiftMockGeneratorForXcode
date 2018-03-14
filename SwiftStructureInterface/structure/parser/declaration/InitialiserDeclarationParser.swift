class InitialiserDeclarationParser: DeclarationParser<Initialiser> {

    override func parseDeclaration(offset: Int64) -> Initialiser {
        advance(if: .postfixQuestion)
        advance(if: .postfixExclaim)
        advance(if: .leftParen)
        advance(if: .rightParen)
        let length = convert(getPreviousEndLocation())! - offset
        let text = getString(offset: offset, length: length)!
        return SwiftInitialiser(text: text, children: [], offset: offset, length: length)
    }
}
