import Lexer

class MutationModifierParser: ModifierParser {

    static let modifiers: [(Token.Kind, String)] = [
        (.mutating, "mutating"),
        (.nonmutating, "nonmutating")
    ]

    override var modifiers: [(Token.Kind, String)] {
        return MutationModifierParser.modifiers
    }

    override var argumentModifiers: [(Token.Kind, String)] {
        return []
    }
}
