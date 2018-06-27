class DeclarationsParser: Parser<[Element]> {

    private var braceLevel = 0

    override func parse(start: LineColumn) -> [Element] {
        var elements = [Element]()
        while let element = parseDeclaration() {
            elements.append(element)
        }
        return elements
    }

    private func parseDeclaration() -> Element? {
        if isEndOfParsing() {
            return nil
        } else if isNextDeclaration(.protocol) {
            return try? parseProtocolDeclaration()
        } else if isNextDeclaration(.func) {
            return try? parseFunctionDeclaration()
        } else if isNextDeclaration(.var) {
            return try? parseVariableDeclaration()
        } else if isNextDeclaration(.identifier("associatedtype", false)) {
            return try? parseAssociatedTypeDeclaration()
        } else if isNextDeclaration(.typealias) {
            return try? parseTypealiasDeclaration()
        } else if isNextDeclaration(.init) {
            return try? parseInitializerDeclaration()
        } else if isNextDeclaration(.subscript) {
            return try? parseSubscriptDeclaration()
        } else {
            adjustBraceLevel()
            advance()
            return parseDeclaration()
        }
    }

    private func isEndOfParsing() -> Bool {
        return isEndOfParentDeclaration() || isEndOfFile()
    }

    private func adjustBraceLevel() {
        if isNext(.leftBrace) {
            braceLevel += 1
        } else if isNext(.rightBrace) {
            braceLevel -= 1
        }
    }

    private func isEndOfParentDeclaration() -> Bool {
        return braceLevel == 0 && isNext(.rightBrace)
    }

    private func isEndOfFile() -> Bool {
        return isNext(.eof)
    }
}
