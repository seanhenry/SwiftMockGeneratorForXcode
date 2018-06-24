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

    override func parse(start: LineColumn) -> DeclarationModifier {
        if modifiers.contains(String(describing: peekAtNextKind())) {
            return DeclarationModifierImpl(children: DeclarationModifierParser.parseModifier(self))
        }
        return parseOtherModifier() ?? createEmptyModifier()
    }

    static func parseModifier<T>(_ parser: Parser<T>) -> [Any?] {
        return [
            parser.parseKeyword(),
            parseModifierArgument(parser)
        ]
    }

    private static func parseModifierArgument<T>(_ parser: Parser<T>) -> [Element]? {
        return parser.tryToParse {
            return [
                try parser.parsePunctuation(.leftParen),
                parser.parseKeyword(),
                try parser.parsePunctuation(.rightParen)
            ]
        }
    }

    private func parseOtherModifier() -> DeclarationModifier? {
        let accessLevelModifier = parseAccessLevelModifier()
        if (accessLevelModifier !== AccessLevelModifierImpl.emptyAccessLevelModifier) {
            return accessLevelModifier
        }
        let mutationModifier = parseMutationModifier()
        if (mutationModifier !== MutationModifierImpl.emptyMutationModifier) {
            return mutationModifier
        }
        return nil
    }

    private func createEmptyModifier() -> AccessLevelModifier {
        return AccessLevelModifierImpl.emptyAccessLevelModifier
    }
}
