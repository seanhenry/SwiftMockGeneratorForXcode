class SubscriptDeclarationParser: DeclarationParser<SubscriptDeclaration> {

    override func parseDeclaration(offset: Int64) -> SubscriptDeclaration {
        _ = parseGenericParameterClause()
        _ = parseFunctionDeclarationParameterClause()
        _ = parseFunctionDeclarationResult()
        _ = parseWhereClause()
        _ = parseGetterSetterKeywordBlock()
        let length = convert(getPreviousEndLocation())! - offset
        let text = getString(offset: offset, length: length)!
        return SwiftSubscriptDeclaration(text: text, children: [], offset: offset, length: length)
    }
}
