import Source

class ProtocolDeclarationParser: DeclarationParser<TypeDeclaration> {

    override func parseDeclaration(start: LineColumn, accessLevelModifier: AccessLevelModifier) -> TypeDeclaration {
        var name = ""
        tryToAppendIdentifier(to: &name)
        let inheritanceClause = parseTypeInheritanceClause()
        skipWhereClause()
        let codeBlock = parseTypeCodeBlock()
        return createElement(start: start) { offset, length, text in
            return TypeDeclarationImpl(
                name: name,
                text: text,
                children: inheritanceClause + codeBlock.declarations,
                inheritedTypes: inheritanceClause,
                offset: offset,
                length: length,
                bodyOffset: codeBlock.offset,
                bodyLength: codeBlock.length,
                accessLevelModifier: accessLevelModifier)
        } ?? TypeDeclarationImpl.errorTypeDeclaration
    }

    private func skipWhereClause() {
        _ = parseWhereClause()
    }
}
