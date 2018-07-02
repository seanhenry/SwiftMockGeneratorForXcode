class StatementParser: Parser<Statement> {

    class ErrorStatement: ElementImpl, Statement {}

    private var braceLevel = 0

    override func parse() throws -> Statement {
        if isEndOfParsing() {
            throw LookAheadError()
        } else if let declaration = try? parseDeclaration() {
            return declaration
        } else if let expression = try? parseExpression() {
            return expression
        } else {
            adjustBraceLevel()
            guard let text = getSubstring(getCurrentStartLocation(), getCurrentEndLocation()) else {
                throw LookAheadError()
            }
            advance()
            return ErrorStatement(children: [LeafNodeImpl(text: text)])
        }
    }

    func isEndOfParsing() -> Bool {
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

    func isEndOfFile() -> Bool {
        return isNext(.eof)
    }
}
