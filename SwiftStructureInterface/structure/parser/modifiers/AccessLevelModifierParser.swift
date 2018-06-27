import Lexer

class AccessLevelModifierParser: Parser<AccessLevelModifier> {

    private static let modifiers: Set<String> = [
        String(describing: Token.Kind.private),
        String(describing: Token.Kind.fileprivate),
        String(describing: Token.Kind.internal),
        String(describing: Token.Kind.public),
        String(describing: Token.Kind.open),
    ]

    private var modifiers: Set<String> {
        return AccessLevelModifierParser.modifiers
    }

    override func parse() throws -> AccessLevelModifier {
        return AccessLevelModifierImpl(children:
          try DeclarationModifierParser.parseModifier(self, modifiers: modifiers)
        )
    }
}
