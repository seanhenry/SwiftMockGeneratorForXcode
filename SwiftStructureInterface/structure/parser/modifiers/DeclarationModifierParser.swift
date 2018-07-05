import Lexer

class DeclarationModifierParser: Parser<DeclarationModifier> {

    private static let modifiers: Set<String> = [
        String(describing: Token.Kind.class),
        String(describing: Token.Kind.convenience),
        String(describing: Token.Kind.dynamic),
        String(describing: Token.Kind.final),
        String(describing: Token.Kind.infix),
        String(describing: Token.Kind.lazy),
        String(describing: Token.Kind.optional),
        String(describing: Token.Kind.override),
        String(describing: Token.Kind.postfix),
        String(describing: Token.Kind.prefix),
        String(describing: Token.Kind.required),
        String(describing: Token.Kind.static),
        String(describing: Token.Kind.unowned),
        String(describing: Token.Kind.weak)
    ]

    private var modifiers: Set<String> {
        return DeclarationModifierParser.modifiers
    }

    override func parse() throws -> DeclarationModifier {
        if let modifier = parseAnyModifier() {
            return modifier
        }
        throw LookAheadError()
    }

    private func parseAnyModifier() -> DeclarationModifier? {
        return (try? parseDeclarationModifierOnly())
                ?? (try? parseAccessLevelModifier())
                ?? (try? parseMutationModifier())
    }

    private func parseDeclarationModifierOnly() throws -> DeclarationModifier {
        return DeclarationModifierImpl(children:
          try DeclarationModifierParser.parseModifier(self, modifiers: modifiers)
        )
    }

    static func parseModifier<T>(_ parser: Parser<T>, modifiers: Set<String>) throws -> [Element] {
        let key = String(describing: parser.peekAtNextKind())
        guard modifiers.contains(key) else {
            throw LookAheadError()
        }
        return try parser.builder()
                .required { try parser.parseKeyword() }
                .optional { try self.parseModifierArgument(parser) }
                .build()
    }

    private static func parseModifierArgument<T>(_ parser: Parser<T>) throws -> Element {
        return try ElementImpl(children: parser.builder()
                .required { try parser.parsePunctuation(.leftParen) }
                .optional { try parser.parseKeyword() }
                .optional { try parser.parseStrictIdentifier() }
                .required { try parser.parsePunctuation(.rightParen) }
                .build())
    }
}
