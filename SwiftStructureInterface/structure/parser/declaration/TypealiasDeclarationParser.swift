class TypealiasDeclarationParser: DeclarationParser<TypealiasDeclaration> {

    override func parseDeclaration(start: LineColumn, children: [Any?]) -> TypealiasDeclaration {
        var name = ""
        tryToAppendIdentifier(to: &name)
        _ = parseGenericParameterClause()
        let assignment = parseTypealiasAssignment()
        return createElement(start: start) { offset, length, text in
            return TypealiasImpl(
                text: text,
                offset: offset,
                length: length,
                name: name,
                typealiasAssignment: assignment)
        } ?? TypealiasImpl.emptyTypealias
    }
}
