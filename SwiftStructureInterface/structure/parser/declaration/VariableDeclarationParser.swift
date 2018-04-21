import Source

class VariableDeclarationParser: DeclarationParser<VariableDeclaration> {

    override func parseDeclaration(start: LineColumn) -> VariableDeclaration {
        var name = ""
        tryToAppendIdentifier(to: &name)
        let type = parseTypeAnnotation()
        let block = parseGetterSetterKeywordBlock()
        return createElement(start: start) { offset, length, text in
            return SwiftVariableDeclaration(
                name: name,
                text: text,
                children: [type],
                offset: offset,
                length: length,
                type: type,
                isWritable: block.isWritable)
        } ?? SwiftVariableDeclaration.errorVariableDeclaration
    }

    private func parseTypeAnnotation() -> Type {
        advance(if: .colon)
        _ = parseAttributes()
        skipInout()
        return parseType()
    }
}
