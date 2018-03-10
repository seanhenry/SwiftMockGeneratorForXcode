import Source

class ProtocolDeclarationParser: DeclarationParser<SwiftTypeElement> {

    override func parseDeclaration(offset: Int64) -> SwiftTypeElement {
        var name = ""
        tryToAppendIdentifier(to: &name)
        let inheritanceClause = parseInheritanceClause()
        skipWhereClause()
        let codeBlock = parseTypeCodeBlock()
        let length = codeBlock.bodyEnd - offset
        let text = getString(offset: offset, length: length)!
        return SwiftTypeElement(
            name: name,
            text: text,
            children: codeBlock.declarations,
            inheritedTypes: inheritanceClause,
            offset: offset,
            length: length,
            bodyOffset: codeBlock.offset,
            bodyLength: codeBlock.length)
    }

    private func skipWhereClause() {
        _ = parseWhereClause()
    }
}
