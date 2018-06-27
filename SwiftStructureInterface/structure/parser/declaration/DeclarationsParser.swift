import Lexer

class DeclarationsParser<T>: Parser<T> {

    private var braceLevel = 0

    func parseDeclaration() throws -> Element {
        if isEndOfParsing() {
            throw LookAheadError()
        } else if let declaration = try? parseProtocolDeclaration() {
            return declaration
        } else if let declaration = try? parseFunctionDeclaration() {
            return declaration
        } else if let declaration = try? parseVariableDeclaration() {
            return declaration
        } else if let declaration = try? parseAssociatedTypeDeclaration() {
            return declaration
        } else if let declaration = try? parseTypealiasDeclaration() {
            return declaration
        } else if let declaration = try? parseInitializerDeclaration() {
            return declaration
        } else if let declaration = try? parseSubscriptDeclaration() {
            return declaration
        } else {
            adjustBraceLevel()
            guard let text = getSubstring(getCurrentStartLocation(), getCurrentEndLocation()) else {
                throw LookAheadError()
            }
            advance()
            return ElementImpl(children: [LeafNodeImpl(text: text)])
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
