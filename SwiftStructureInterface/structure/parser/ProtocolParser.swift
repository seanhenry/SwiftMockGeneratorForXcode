class ProtocolParser: Parser<SwiftTypeElement> {

    override func parse() -> SwiftTypeElement {
        guard isNext(.protocol) else { fatalError("Expected a protocol. Check isNext(.protocol) before parsing a protocol") }
        let start = getCurrentStartLocation()
        advance()
        let offset = convert(start)!
        var name = ""
        if let n = peekAtNextIdentifier() {
            advance()
            name = n
        }
        let inheritanceClause = parseInheritanceClause()
        let (bodyOffset, bodyLength, bodyEnd, declarations) = parseTypeCodeBlock()
        let length = bodyEnd - offset
        let text = getString(offset: offset, length: length)!
        return SwiftTypeElement(
            name: name,
            text: text,
            children: declarations,
            inheritedTypes: inheritanceClause,
            offset: offset,
            length: length,
            bodyOffset: bodyOffset,
            bodyLength: bodyLength)
    }
}
