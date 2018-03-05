import Source

class ProtocolParser: Parser<SwiftTypeElement> {

    override func parse() -> SwiftTypeElement {
        let start = getCurrentStartLocation()
        _ = parseAttributes()
        skipAccessModifier()
        return parseDeclaration(start: start)
    }

    func parseDeclaration(start: SourceLocation) -> SwiftTypeElement {
        guard isNext(.protocol) else { fatalError("Expected a protocol. Check isNext(.protocol) before parsing a protocol") }
        advance()
        let offset = convert(start)!
        var name = ""
        if let n = peekAtNextIdentifier() {
            advance()
            name = n
        }
        let inheritanceClause = parseInheritanceClause()
        _ = parseWhereClause()
        let codeBlock = parseTypeCodeBlock()
        let length = codeBlock.bodyEnd - offset
        let text = getString(offset: offset, length: length)!
        return SwiftTypeElement(
            name: name,
            text: text,
            children: codeBlock.declarations,
            inheritedTypes: inheritanceClause,
            offset: offset,
            length: length,
            bodyOffset: codeBlock.offset,
            bodyLength: codeBlock.length)
    }
}
