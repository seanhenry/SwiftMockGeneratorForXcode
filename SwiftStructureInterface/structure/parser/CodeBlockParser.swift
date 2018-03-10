typealias CodeBlock = (offset: Int64, length: Int64, bodyEnd: Int64, declarations: [Element])

class CodeBlockParser: Parser<CodeBlock> {

    override func parse() -> CodeBlock {
        let bodyStart = getCurrentEndLocation()
        advance(if: .leftBrace)

        let declarations = parseDeclarations()

        let bodyOffset = convert(bodyStart)!
        let bodyLength = convert(getCurrentStartLocation())! - bodyOffset
        var rightBraceLength: Int64 = 0
        if isNext(.rightBrace) {
            rightBraceLength = 1
            advance()
        }
        return (bodyOffset, bodyLength, bodyOffset + bodyLength + rightBraceLength, declarations)
    }
}
