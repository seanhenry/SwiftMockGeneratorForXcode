import Source

class ProtocolDeclarationParser: DeclarationParser<TypeDeclaration> {

    override func parseDeclaration(start: LineColumn, children: [Any?]) -> TypeDeclaration {
        var name = ""
        tryToAppendIdentifier(to: &name)
        let inheritanceClause = parseTypeInheritanceClause()
        skipWhereClause()
        let codeBlock = parseTypeCodeBlock()
        return createElement(start: start) { offset, length, text in
            return TypeDeclarationImpl(
                text: text,
                offset: offset,
                length: length,
                bodyOffset: codeBlock.offset,
                bodyLength: codeBlock.length,
                name: name,
                accessLevelModifier: accessLevelModifier,
                inheritedTypes: inheritanceClause,
                declarations: codeBlock.declarations)
        } ?? TypeDeclarationImpl.emptyTypeDeclaration
    }

    private func skipWhereClause() {
        _ = parseWhereClause()
    }
}
