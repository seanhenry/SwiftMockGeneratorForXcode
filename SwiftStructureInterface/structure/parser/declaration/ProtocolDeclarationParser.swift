import Source

class ProtocolDeclarationParser: DeclarationParser<SwiftTypeElement> {

    override func parseDeclaration(start: LineColumn) -> SwiftTypeElement {
        var name = ""
        tryToAppendIdentifier(to: &name)
        let inheritanceClause = parseTypeInheritanceClause()
        skipWhereClause()
        let codeBlock = parseTypeCodeBlock()
        return createElement(start: start) { offset, length, text in
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
