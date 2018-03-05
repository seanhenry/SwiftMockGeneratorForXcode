import Lexer

class AttributeParser: Parser<String> {

    private class Error: Swift.Error {}

    override func parse() -> String {
        var attributes = [String]()
        while isNext(.at) {
            attributes.append(parseAttribute())
        }
        return attributes.joined(separator: " ")
    }

    private func parseAttribute() -> String {
        var attribute = ""
        do {
            try append(.at, value: "@", to: &attribute)
            try appendIdentifier(to: &attribute)
            try append(.leftParen, value: "(", to: &attribute)
            try appendIdentifier(to: &attribute)
            try append(.rightParen, value: ")", to: &attribute)
        } catch {} // ignored
        return attribute
    }

    private func append(_ kind: Token.Kind, value: String, to string: inout String) throws {
        if isNext(kind) {
            advance()
            string += value
        } else {
            throw Error()
        }
    }

    private func appendIdentifier(to string: inout String) throws {
        if let argument = peekAtNextIdentifier() {
            advance()
            string += argument
        } else {
            throw Error()
        }
    }
}
