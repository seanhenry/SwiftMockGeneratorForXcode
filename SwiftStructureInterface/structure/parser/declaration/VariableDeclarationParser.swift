import Source

class VariableDeclarationParser: DeclarationParser<VariableDeclaration> {

    override func parseDeclaration(start: LineColumn, accessLevelModifier: AccessLevelModifier) -> VariableDeclaration {
        var name = ""
        tryToAppendIdentifier(to: &name)
        let type = parseTypeAnnotation()
        let block = parseGetterSetterKeywordBlock()
        return createElement(start: start) { offset, length, text in
            return VariableDeclarationImpl(
                name: name,
                text: text,
                children: [type, block],
                offset: offset,
                length: length,
                type: type,
                isWritable: block.isWritable)
        } ?? VariableDeclarationImpl.errorVariableDeclaration
    }

    private func parseTypeAnnotation() -> Type {
        advance(if: .colon)
        _ = parseAttributes()
        skipInout()
        return parseType()
    }
}
