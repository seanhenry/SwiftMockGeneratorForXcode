class DeclarationsParser: Parser<[Element]> {

    override func parse() -> [Element] {
        var elements = [Element]()
        if isNextDeclaration(.protocol) {
            elements.append(parseProtocol())
        } else if isNextDeclaration(.func) {
            elements.append(parseFunctionDeclaration())
        } else if isUnexpectedToken() {
            advance()
            return parse()
        }
        return elements
    }

    private func isUnexpectedToken() -> Bool {
        return !isEndOfParentDeclaration() && !isEndOfFile()
    }

    private func isEndOfParentDeclaration() -> Bool {
        return isNext(.rightBrace)
    }

    private func isEndOfFile() -> Bool {
        return isNext(.eof)
    }
}
