class SubscriptDeclarationParser: DeclarationParser<SubscriptDeclaration> {

    override func parseDeclaration(start: LineColumn, accessLevelModifier: AccessLevelModifier) -> SubscriptDeclaration {
        _ = parseGenericParameterClause()
        _ = parseFunctionDeclarationParameterClause()
        _ = parseFunctionDeclarationResult()
        _ = parseWhereClause()
        _ = parseGetterSetterKeywordBlock()
        return createElement(start: start) { offset, length, text in
            return SwiftSubscriptDeclaration(text: text, children: [], offset: offset, length: length)
        } ?? SwiftSubscriptDeclaration.errorSubscriptDeclaration
    }
}
