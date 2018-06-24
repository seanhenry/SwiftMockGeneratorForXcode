class AttributesParser: Parser<Attributes> {

    override func parse(start: LineColumn) -> Attributes {
        var attributes = [Element?]()
        attributes.append(parseAttribute())
        while isNext(.at) {
            attributes.append(parseWhitespace())
            attributes.append(parseAttribute())
        }
        return AttributesImpl(children: attributes)
    }

    private func parseAttribute() -> Attribute? {
        do {
            return AttributeImpl(children: [
                try parsePunctuation(.at),
                try? parseIdentifier(),
                parseArguments()
            ])
        } catch {}
        return nil
    }

    private func parseArguments() -> [Element?] {
        return tryToParse {
            let args: [Element] = [
                try parsePunctuation(.leftParen),
                try parseIdentifier(),
                try parsePunctuation(.rightParen)
            ]
            return args
        } ?? []
    }
}
