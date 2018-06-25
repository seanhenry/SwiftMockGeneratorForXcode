class ParameterParser: Parser<Parameter> {

    override func parse(start: LineColumn) -> Parameter {
        if isNext(.eof) {
            return ParameterImpl.emptyParameter
        }
        return ParameterImpl(children: [
            parseUnderscoreAndWhitespace(),
            tryToParseParameterIdentifier(),
            tryToParseParameterIdentifier(),
            parseTypeAnnotation(),
            parseVarArgs()
        ])
    }

    private func tryToParseParameterIdentifier() -> [Any?] {
        let identifier = tryToParseIdentifier()
        if !identifier.isEmpty {
            return identifier
        } else if case let .booleanLiteral(bool) = peekAtNextKind() {
            advance()
            let identifier = IdentifierImpl(text: String(describing: bool))
            return [identifier, parseWhitespace()]
        } else {
            let keyword = parseKeyword()
            if keyword !== LeafNodeImpl.emptyLeafNode {
                return [IdentifierImpl(text: keyword.text), parseWhitespace()]
            }
        }
        return []
    }

    private func parseVarArgs() -> Element? {
        if isPostfixOperator("...") {
            return LeafNodeImpl(text: "...")
        }
        return nil
    }
}
