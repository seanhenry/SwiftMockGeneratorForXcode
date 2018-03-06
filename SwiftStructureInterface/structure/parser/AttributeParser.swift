class AttributeParser: Parser<String> {

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
}
