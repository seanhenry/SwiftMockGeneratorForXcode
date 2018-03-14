class AttributeParser: Parser<String> {

    override func parse(offset: Int64) -> String {
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
            tryToAppendAttributeArguments(to: &attribute)
        } catch {} // ignored
        return attribute
    }

    private func tryToAppendAttributeArguments(to string: inout String) {
        let arguments: String? = tryToParse {
            var arguments = ""
            try append(.leftParen, value: "(", to: &arguments)
            try appendIdentifier(to: &arguments)
            try append(.rightParen, value: ")", to: &arguments)
            return arguments
        }
        arguments.map { string.append($0) }
    }
}
