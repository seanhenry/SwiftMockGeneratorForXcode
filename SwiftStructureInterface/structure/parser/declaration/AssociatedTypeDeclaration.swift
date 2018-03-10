class AssociatedTypeDeclarationParser: DeclarationParser<Element> {

    override func parseDeclaration(offset: Int64) -> Element {
        if peekAtNextIdentifier() != nil {
            advance()
        }
        _ = parseTypeInheritanceClause()
        _ = parseTypealiasAssignment()
        _ = parseWhereClause()
        let length = convert(getPreviousEndLocation())! - offset
        let text = getString(offset: offset, length: length)!
        return SwiftElement(text: text, children: [], offset: offset, length: length)
    }
}
