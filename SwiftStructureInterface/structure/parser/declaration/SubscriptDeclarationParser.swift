class SubscriptDeclarationParser: DeclarationParser<SubscriptDeclaration> {

    override func parseDeclaration(offset: Int64) -> SubscriptDeclaration {
        _ = parseGenericParameterClause()
        _ = parseFunctionDeclarationParameterClause()
        _ = parseFunctionDeclarationResult()
        _ = parseWhereClause()
        _ = parseGetterSetterKeywordBlock()
        return createElement(offset: offset) { length, text in
            return SwiftSubscriptDeclaration(text: text, children: [], offset: offset, length: length)
        } ?? SwiftSubscriptDeclaration.errorSubscriptDeclaration
    }
}
