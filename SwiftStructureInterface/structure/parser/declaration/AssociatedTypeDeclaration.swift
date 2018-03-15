class AssociatedTypeDeclarationParser: DeclarationParser<Element> {

    override func parseDeclaration(start: LineColumn) -> Element {
        if peekAtNextIdentifier() != nil {
            advance()
        }
        _ = parseTypeInheritanceClause()
        _ = parseTypealiasAssignment()
        _ = parseWhereClause()
        return createElement(start: start) { offset, length, text in
            return SwiftElement(text: text, children: [], offset: offset, length: length)
        } ?? SwiftElement.errorElement
    }
}
