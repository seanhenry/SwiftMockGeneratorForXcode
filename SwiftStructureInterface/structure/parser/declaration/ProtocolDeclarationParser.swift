import Source

class ProtocolDeclarationParser: DeclarationParser<SwiftTypeElement> {

    override func parseDeclaration(offset: Int64) -> SwiftTypeElement {
        var name = ""
        tryToAppendIdentifier(to: &name)
        let inheritanceClause = parseTypeInheritanceClause()
        skipWhereClause()
        let codeBlock = parseTypeCodeBlock()
        return createElement(offset: offset) { length, text in
            return SwiftTypeElement(
                name: name,
                text: text,
                children: codeBlock.declarations,
                inheritedTypes: inheritanceClause,
                offset: offset,
                length: length,
                bodyOffset: codeBlock.offset,
                bodyLength: codeBlock.length)
        } ?? SwiftTypeElement.errorTypeElement
    }

    private func skipWhereClause() {
        _ = parseWhereClause()
    }
}
