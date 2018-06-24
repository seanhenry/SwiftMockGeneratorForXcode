class AssociatedTypeDeclarationParser: DeclarationParser<Element> {

    override func parseDeclaration(start: LineColumn, children: [Any?]) -> Element {
        if peekAtNextIdentifier() != nil {
            advance()
        }
        _ = parseTypeInheritanceClause()
        _ = parseTypealiasAssignment()
        _ = parseWhereClause()
        fatalError("TODO:")
//        return createElement(start: start) { offset, length, text in
//            return ElementImpl(text: text, children: [], offset: offset, length: length)
//        } ?? ElementImpl.emptyElement
    }
}
