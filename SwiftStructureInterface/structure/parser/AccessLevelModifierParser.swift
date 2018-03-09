import Lexer

class AccessLevelModifierParser: ModifierParser {

    override var modifiers: [(Token.Kind, String)] {
        return [
            (.private, "private"),
            (.fileprivate, "fileprivate"),
            (.internal, "internal"),
            (.public, "public"),
            (.open, "open")
        ]
    }

    override var argumentModifiers: [(Token.Kind, String)] {
        return modifiers
    }
}
