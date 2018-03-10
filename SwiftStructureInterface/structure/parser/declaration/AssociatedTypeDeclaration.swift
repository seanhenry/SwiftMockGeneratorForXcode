class AssociatedTypeDeclarationParser: DeclarationParser<Element> {

    override func parseDeclaration(offset: Int64) -> Element {
        if peekAtNextIdentifier() != nil {
            advance()
        }
        let length = convert(getCurrentEndLocation())!
        let text = getString(offset: offset, length: length)!
        return SwiftElement(text: text, children: [], offset: offset, length: length)
    }
}
