import Source

class ProtocolDeclarationParser: DeclarationParser<TypeDeclaration> {

    override func parseDeclaration(start: LineColumn) -> TypeDeclaration {
        var name = ""
        tryToAppendIdentifier(to: &name)
        let inheritanceClause = parseTypeInheritanceClause()
        skipWhereClause()
        let codeBlock = parseTypeCodeBlock()
        return createElement(start: start) { offset, length, text in
            return SwiftTypeDeclaration(
                name: name,
                text: text,
                children: inheritanceClause + codeBlock.declarations,
                inheritedTypes: inheritanceClause,
                offset: offset,
                length: length,
                bodyOffset: codeBlock.offset,
                bodyLength: codeBlock.length)
        } ?? SwiftTypeDeclaration.errorTypeDeclaration
    }

    private func skipWhereClause() {
        _ = parseWhereClause()
    }
}
