class ProtocolParser: Parser<SwiftTypeElement> {

    override func parse() -> SwiftTypeElement? {
        guard isNext(.protocol) else { return nil }
        let start = getCurrentStartLocation()
        advance()
        let offset = convert(start)!
        let name = peekAtNextIdentifier()!
        advance()
        if let inheritanceClause = parseInheritanceClause(),
           let (bodyOffset, bodyLength, bodyEnd, declarations) = parseTypeCodeBlock() {
            let length = bodyEnd - offset
            let text = getSubstring(from: sourceFile.content, offset: offset, length: length)!
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
        return nil
    }
}
