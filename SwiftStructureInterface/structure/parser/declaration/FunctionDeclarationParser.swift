import Source

class FunctionDeclarationParser: DeclarationParser<FunctionDeclaration> {

    override func parseDeclaration(start: LineColumn, children: [Any?]) -> FunctionDeclaration {
        var name = ""
        try! appendIdentifier(to: &name)
        let genericParameterClause = parseGenericParameterClause()
        let parameters = parseParameterClause()
        let `throws` = parseThrows()
        skipRethrows()
        let returnType = parseReturnType()
        skipWhereClause()
        return createElement(start: start) { offset, length, text in
            return FunctionDeclarationImpl(
                text: text,
                offset: offset,
                length: length,
                name: name,
                genericParameterClause: genericParameterClause,
                parameters: parameters,
                returnType: returnType,
                throws: `throws`,
                declarations: [])
        } ?? FunctionDeclarationImpl.emptyFunctionDeclaration
    }

    private func parseParameterClause() -> [Parameter] {
        return parseFunctionDeclarationParameterClause()
    }

    private func parseThrows() -> Bool {
        if isNext(.throws) {
            advance()
            return true
        }
        return false
    }

    private func skipRethrows() {
        advance(if: .rethrows)
    }

    private func parseReturnType() -> Element? {
        let result = parseFunctionDeclarationResult()
        if result !== TypeImpl.emptyType {
            return result
        }
        return nil
    }

    private func skipWhereClause() {
        _ = parseWhereClause()
    }

    class ResultParser: Parser<Element> {

        override func parse(start: LineColumn) -> Element {
            guard isNext(.arrow) else {
                return TypeImpl.emptyType
            }
            advance()
            _ = parseAttributes()
            return parseType()
        }
    }
}
