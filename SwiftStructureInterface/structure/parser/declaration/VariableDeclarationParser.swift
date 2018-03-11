import Source

class VariableDeclarationParser: DeclarationParser<VariableDeclaration> {

    override func parseDeclaration(offset: Int64) -> VariableDeclaration {
        var name = ""
        tryToAppendIdentifier(to: &name)
        let type = parseTypeAnnotation()
        let block = parseGetterSetterBlock()
        let length = convert(getPreviousEndLocation())! - offset
        let text = getString(offset: offset, length: length)!
        return SwiftVariableDeclaration(
            name: name,
            text: text,
            children: [],
            offset: offset,
            length: length,
            type: type,
            isWritable: block.isWritable)
    }

    private func parseTypeAnnotation() -> Type {
        advance(if: .colon)
        _ = parseAttributes()
        skipInout()
        return parseType()
    }
}
