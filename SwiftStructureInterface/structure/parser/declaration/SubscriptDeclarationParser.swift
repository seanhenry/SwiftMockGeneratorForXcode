class SubscriptDeclarationParser: DeclarationParser<SubscriptDeclaration> {

    override func parseDeclaration(start: LineColumn, children: [Any?]) -> SubscriptDeclaration {
        _ = parseGenericParameterClause()
        _ = parseFunctionDeclarationParameterClause()
        _ = parseFunctionDeclarationResult()
        _ = parseWhereClause()
        _ = parseGetterSetterKeywordBlock()
        return createElement(start: start) { offset, length, text in
            return SubscriptDeclarationImpl(text: text, offset: offset, length: length, declarations: [])
        } ?? SubscriptDeclarationImpl.emptySubscriptDeclaration
    }
}
