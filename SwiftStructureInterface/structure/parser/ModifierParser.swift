import Lexer

class ModifierParser: Parser<String> {

    var modifiers: [(Token.Kind, String)] {
        fatalError("Override me")
    }

    var argumentModifiers: [(Token.Kind, String)] {
        fatalError("Override me")
    }

    override func parse() -> String {
        var modifiers = [String]()
        while let modifier = parseArgumentModifiers() ?? parseOtherModifiers() {
            modifiers.append(modifier)
        }
        return modifiers.joined(separator: " ")
    }

    private func parseArgumentModifiers() -> String? {
        for (kind, string) in argumentModifiers {
            if let modifier = parseArgumentModifier(kind: kind, string: string) {
                return modifier
            }
        }
        return nil
    }

    private func parseArgumentModifier(kind: Token.Kind, string: String) -> String? {
        return tryToParse {
            guard isNext(kind) else { throw LookAheadError() }
            var modifier = string
            advance()
            try append(.leftParen, value: "(", to: &modifier)
            try appendIdentifier(to: &modifier)
            try append(.rightParen, value: ")", to: &modifier)
            return modifier
        }
    }

    private func parseOtherModifiers() -> String? {
        for (kind, string) in modifiers {
            if isNext(kind) {
                advance()
                return string
            }
        }
        return nil
    }
}
