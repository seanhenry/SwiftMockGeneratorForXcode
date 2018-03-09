import Lexer

class DeclarationModifierParser: ModifierParser {

    override var modifiers: [(Token.Kind, String)] {
        return [
            (.class, "class"),
            (.convenience, "convenience"),
            (.dynamic, "dynamic"),
            (.final, "final"),
            (.infix, "infix"),
            (.lazy, "lazy"),
            (.optional, "optional"),
            (.override, "override"),
            (.postfix, "postfix"),
            (.prefix, "prefix"),
            (.required, "required"),
            (.static, "static"),
            (.unowned, "unowned"),
            (.weak, "weak")
        ] + AccessLevelModifierParser.modifiers
          + MutationModifierParser.modifiers
    }

    override var argumentModifiers: [(Token.Kind, String)] {
        return [
            (.unowned, "unowned")
        ] + AccessLevelModifierParser.argumentModifiers
    }
}
