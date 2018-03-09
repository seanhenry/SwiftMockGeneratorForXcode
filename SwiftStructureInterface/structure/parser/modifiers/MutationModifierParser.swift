import Lexer

class MutationModifierParser: ModifierParser {

    override var modifiers: [(Token.Kind, String)] {
        return [
            (.mutating, "mutating"),
            (.nonmutating, "nonmutating")
        ]
    }

    override var argumentModifiers: [(Token.Kind, String)] {
        return []
    }
}
