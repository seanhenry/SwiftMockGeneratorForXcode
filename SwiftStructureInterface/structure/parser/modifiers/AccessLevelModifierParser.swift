import Lexer

class AccessLevelModifierParser: ModifierParser {

    static let modifiers: [(Token.Kind, String)] = [
        (.private, "private"),
        (.fileprivate, "fileprivate"),
        (.internal, "internal"),
        (.public, "public"),
        (.open, "open")
    ]

    static var argumentModifiers: [(Token.Kind, String)] {
        return modifiers
    }

    override var modifiers: [(Token.Kind, String)] {
        return AccessLevelModifierParser.modifiers
    }

    override var argumentModifiers: [(Token.Kind, String)] {
        return AccessLevelModifierParser.argumentModifiers
    }
}
