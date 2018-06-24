class VariableDeclarationParser: DeclarationParser<VariableDeclaration> {

    override func parseDeclaration(start: LineColumn, children: [Any?]) -> VariableDeclaration {
        return VariableDeclarationImpl(children: children + [
            parseWhitespace(),
            try? parseIdentifier(),
            parseTypeAnnotation(),
            parseWhitespace(),
            parseGetterSetterKeywordBlock()
        ])
    }
}
