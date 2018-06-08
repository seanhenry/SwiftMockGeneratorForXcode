import Lexer

class AccessLevelModifierParser: Parser<AccessLevelModifier> {

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

    var modifiers: [(Token.Kind, String)] {
        return AccessLevelModifierParser.modifiers
    }

    var argumentModifiers: [(Token.Kind, String)] {
        return AccessLevelModifierParser.argumentModifiers
    }

    override func parse(start: LineColumn) -> AccessLevelModifier {
        for modifier in modifiers where isNext(modifier.0) {
            advance()
            parseModifierArgument()
            return createModifier(start: start)
        }
        return createEmptyModifier()
    }

    private func parseModifierArgument() {
        tryToParse {
            try advanceOrFail(if: .leftParen)
            try advanceIfIdentifierOrFail()
            try advanceOrFail(if: .rightParen)
        }
    }

    private func createModifier(start: LineColumn) -> AccessLevelModifier {
        return createElement(start: start) { offset, length, text in
            return AccessLevelModifierImpl(text: text, children: [], offset: offset, length: length)
        } ?? createEmptyModifier()
    }

    private func createEmptyModifier() -> AccessLevelModifier {
        return AccessLevelModifierImpl.emptyAccessLevelModifier
    }
}
