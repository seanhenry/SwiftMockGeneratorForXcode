class AssociatedTypeDeclarationParser: DeclarationParser<Element> {

    override func parseDeclaration(offset: Int64) -> Element {
        if peekAtNextIdentifier() != nil {
            advance()
        }
        _ = parseTypeInheritanceClause()
        _ = parseTypealiasAssignment()
        _ = parseWhereClause()
        return createElement(offset: offset) { length, text in
            return SwiftElement(text: text, children: [], offset: offset, length: length)
        } ?? SwiftElement.errorElement
    }
}
