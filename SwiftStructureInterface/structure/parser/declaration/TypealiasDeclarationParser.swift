class TypealiasDeclarationParser: DeclarationParser<TypealiasDeclaration> {

    override func parseDeclaration(start: LineColumn, children: [Any?]) -> TypealiasDeclaration {
        return TypealiasDeclarationImpl(children: children + [
            parseWhitespace(),
            tryToParseIdentifier(),
            tryToParseGenericParameterClause(),
            parseTypealiasAssignment()
        ])
    }
}
