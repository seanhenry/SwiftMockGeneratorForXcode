import Lexer

class DeclarationParser: Parser<Declaration> {

    override func parse() throws -> Declaration {
        if let declaration = try? parseProtocolDeclaration() {
            return declaration
        } else if let declaration = try? parseClassDeclaration() {
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
            throw LookAheadError()
        }
    }
}
