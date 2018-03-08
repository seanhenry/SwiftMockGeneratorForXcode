import Source

class FunctionDeclarationParser: DeclarationParser<NamedElement> {

    override func parseDeclaration(offset: Int64) -> NamedElement {
        var name = ""
        try! appendIdentifier(to: &name)
        _ = parseParameterClause()
        let end = convert(getPreviousEndLocation())!
        let length = end - offset
        let text = getString(offset: offset, length: length)!
        return SwiftMethodElement(name: name, text: text, children: [], offset: offset, length: length, returnType: nil, parameters: [])
    }

    class ParameterParser: Parser<MethodParameter> {
        override func parse() -> MethodParameter {
            guard let localParameterName = peekAtNextIdentifier() else { return SwiftMethodParameter.errorMethodParameter }
            advance()
            var s = ""
            tryToAppendTypeAnnotation(to: &s)
            return SwiftMethodParameter(text: "", children: [], offset: -1, length: -1, type: SwiftElement(text: "", children: [], offset: -1, length: -1))
        }
    }

    private func parseParameterClause() -> [MethodParameter] {
        if isNext(.leftParen) {
            advance()
        }
        parseParameter()
        if isNext(.rightParen) {
            advance()
        }
        return []
    }

    private func parseParameter() -> MethodParameter {
        return parseFunctionDeclarationParameter()
    }
}
