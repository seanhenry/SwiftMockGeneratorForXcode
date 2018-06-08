class AssociatedTypeDeclarationParser: DeclarationParser<Element> {

    override func parseDeclaration(start: LineColumn, accessLevelModifier: AccessLevelModifier) -> Element {
        if peekAtNextIdentifier() != nil {
            advance()
        }
        _ = parseTypeInheritanceClause()
        _ = parseTypealiasAssignment()
        _ = parseWhereClause()
        return createElement(start: start) { offset, length, text in
            return ElementImpl(text: text, children: [], offset: offset, length: length)
        } ?? ElementImpl.errorElement
    }
}
